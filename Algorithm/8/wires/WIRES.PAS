{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt;

const
   tfi='WIRES.INP';
   tfo='WIRES.OUT';
   NN=1000;
   maxN=1000;

var
   fi,fo: text;
   N: integer;
   a: array[1..maxN] of integer;
   sl: array[1..maxN] of integer;
   tr: array[1..maxN] of integer;
   slx: integer;
   x: array[1..maxN] of integer;

procedure Sinhdl;
var ch: char;
    i,j,t: integer;
begin
   clrscr;
   writeln('Ban co tao file ',tfi,' (C/K)?');
   repeat ch:=readkey until upcase(ch) in ['C','K'];
   if upcase(ch)='K' then exit;
   randomize;
   N:=NN;
   for i:=1 to N do a[i]:=i;
   for i:=N downto 2 do
      begin
         j:=random(i)+1;
         t:=a[i];
         a[i]:=a[j];
         a[j]:=t;
      end;
   assign(fi,tfi); rewrite(fi);
   writeln(fi,N);
   for i:=1 to N do write(fi,a[i],' ');
   close(fi);
end;

procedure Docdl;
var i,u: integer;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,N);
   for i:=1 to N do
      begin
         read(fi,u);
         a[u]:=i;
      end;
   close(fi);
end;

procedure XDB;
var i,j: integer;
begin
   sl[1]:=1; tr[1]:=-1;
   for i:=2 to N do
      begin
         sl[i]:=1; tr[i]:=-1;
         for j:=i-1 downto 1 do
            if (a[j]<a[i]) and (sl[i]<sl[j]+1) then
               begin
                  sl[i]:=sl[j]+1;
                  Tr[i]:=j;
               end;
      end;
end;

procedure XLB;
var u,i: integer;
begin
   u:=1;
   for i:=2 to N do
      if sl[i]>sl[u] then u:=i;
   slx:=0;
   repeat
      inc(slx);
      x[slx]:=u;
      u:=tr[u];
   until u=-1;
end;

procedure Inkq;
var i: integer;
begin
   assign(fo,tfo); rewrite(fo);
   writeln(fo,slx);
   for i:=slx downto 1 do write(fo,x[i],' ');
   close(fo);
end;

BEGIN
   {Sinhdl;}
   Docdl;
   XDB;
   XLB;
   Inkq;
END.
