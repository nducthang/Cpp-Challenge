{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt;

const
   tfi='TOWN.INP';
   tfo='TOWN.OUT';
   NN=5000;
   maxN=5000;

type
   HH=record  name: integer; c: array[1..3] of byte; end;

var
   fi,fo: text;
   N: integer;
   Khoi: array[1..maxN] of HH;
   a: array[1..maxN] of LongInt;
   Tr: array[1..maxN] of integer;
   slx: integer;
   x: array[1..maxN] of LongInt absolute a;
   Hmax: LongInt;

procedure Sinhdl;
var ch: char;
    i: integer;
    u1,u2,u3: byte;
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
         u1:=random(200)+1;
         u2:=random(200)+1;
         u3:=random(200)+1;
         writeln(fi,u1,' ',u2,' ',u3);
      end;
   close(fi);
end;

procedure Docdl;
var i,k,l: integer;
    tg: byte;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,N);
   for i:=1 to N do
      with khoi[i] do
         begin
            name:=i;
            read(fi,c[1],c[2],c[3]);
            for k:=1 to 2 do
               for l:=k+1 to 3 do
                   if c[k]<c[l] then
                      begin
                         tg:=c[k];
                         c[k]:=c[l];
                         c[l]:=tg;
                      end;
         end;
   close(fi);
end;

function DienTich(u: integer): longint;
var dai,rong: LongInt;
begin
   dai:=Khoi[u].c[1];
   rong:=Khoi[u].c[2];
   DienTich:=Dai*Rong;
end;

procedure Sort(k,l: integer);
var i,j: integer;
    r: LongInt;
    tg: HH;
begin
   i:=k;
   j:=l;
   r:=DienTich((k+l) div 2);
   repeat
      while DienTich(i)>r do inc(i);
      while DienTich(j)<r do dec(j);
      if i<=j then
         begin
            tg:=Khoi[i];
            khoi[i]:=khoi[j];
            khoi[j]:=tg;
            inc(i); dec(j);
         end;
   until i>j;
   if i<l then Sort(i,l);
   if k<j then Sort(k,j);
end;

procedure XDB;
var i,j: integer;
begin
   Sort(1,N);
   for i:=1 to N do
      begin
         a[i]:=Khoi[i].c[3];
         Tr[i]:=-1;
         for j:=i-1 downto 1 do
         if (Khoi[j].c[1]>=Khoi[i].c[1]) and (Khoi[j].c[2]>=Khoi[i].c[2])
         and (a[j]+Khoi[i].c[3]>a[i]) then
            begin
               a[i]:=a[j]+Khoi[i].c[3];
               Tr[i]:=j;
            end;
      end;
end;

procedure XLB;
var u,i: integer;
begin
   u:=1;
   for i:=2 to n do
      if a[i]>a[u] then u:=i;
   Hmax:=a[u];
   slx:=0;
   repeat
      inc(slx);
      x[slx]:=u;
      u:=Tr[u];
   until u=-1;
end;

procedure Inkq;
var i: integer;
begin
   assign(fo,tfo); rewrite(fo);
   writeln(fo,slx);
   for i:=slx downto 1 do
    with Khoi[x[i]] do
       writeln(fo,name,' ',c[2],' ',c[1],' ',c[3]);
   close(fo);
end;

BEGIN
   {Sinhdl;}
   Docdl;
   XDB;
   XLB;
   Inkq;
END.
