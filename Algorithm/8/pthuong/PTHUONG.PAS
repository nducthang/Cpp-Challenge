{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt;

const
   tfi                  =       'PTHUONG.INP';
   tfo                  =       'PTHUONG.OUT';
   maxN                 =       25000;
   NN                   =       5000;

type
   mang                 =       array[1..maxN] of integer;

var
   fi,fo: text;
   N: integer;
   Tr: mang;
   a: array[1..3] of LongInt;
   S: array[0..3] of LongInt;
   x: ^mang;
   slx: integer;


procedure Sinhdl;
var ch: char;
    i,u: LongInt;
begin
   clrscr;
   writeln('Ban co tao file ',tfi,' (C/K)?');
   repeat ch:=readkey until upcase(ch) in ['C','K'];
   if upcase(ch)='K' then exit;
   randomize;
   N:=NN;
   assign(fi,tfi); rewrite(fi);
   writeln(fi,N);
   for i:=1 to N do
      begin
         u:=60;
         u:=random(u)+1;
         writeln(fi,u);
      end;
   close(fi);
end;

procedure Mot;
var u: integer;
begin
   assign(fo,tfo); rewrite(fo);
   readln(fi,u);
   writeln(fo,u,' ',1);
   write(fo,1);
   close(fo);
end;

procedure Hai;
var u,v: integer;
begin
   assign(fo,tfo); rewrite(fo);
   readln(fi,u);
   readln(fi,v);
   writeln(fo,u+v,' ',2);
   write(fo,1,' ',2);
   close(fo);
end;

procedure XDB;
var i: integer;
begin
   for i:=1 to N do Tr[i]:=0;
   read(fi,a[1]);
   read(fi,a[2]);
   tr[1]:=-1;
   tr[2]:=-1;
   s[0]:=0;
   s[1]:=a[1];
   s[2]:=a[1]+a[2];
   for i:=3 to N do
      begin
         read(fi,a[3]);
         s[3]:=s[2]; Tr[i]:=i-1;
         if s[3]<a[3]+s[1] then
            begin
               s[3]:=a[3]+s[1];
               tr[i]:=i-2;
            end;
         if s[3]<a[3]+a[2]+s[0] then
            begin
               s[3]:=a[3]+a[2]+s[0];
               tr[i]:=i-3;
            end;
         a[1]:=a[2];
         a[2]:=a[3];
         s[0]:=s[1];
         s[1]:=s[2];
         s[2]:=s[3];
      end;
end;

procedure XLB;
var u,v,i: integer;
begin
   slx:=0;
   v:=N;
   repeat
      u:=Tr[v];
      for i:=v downto u+2 do
         begin
            inc(slx);
            x^[slx]:=i;
         end;
      v:=u;
   until v<=0;
end;

procedure Inkq;
var i,dem: integer;
begin
   assign(fo,tfo); rewrite(fo);
   writeln(fo,s[3],' ',N);
   dem:=0;
   for i:=slx downto 1 do
      begin
         inc(dem);
         write(fo,x^[i],' ');
         if dem mod 10=0 then writeln(fo);
      end;
   close(fo);
end;

procedure Solve;
begin
   XDB;
   XLB;
   Inkq;
end;


procedure CapPhat;
begin
   New(x);
end;

BEGIN
   CapPhat;
   {Sinhdl;}
   assign(fi,tfi); reset(fi);
   readln(fi,N);
   case N of
      1: Mot;
      2: Hai;
      else Solve;
   end;
   close(fi);
END.