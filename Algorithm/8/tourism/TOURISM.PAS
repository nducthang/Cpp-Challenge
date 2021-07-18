{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
uses crt;

const
   tfi='TOURISM.INP';
   tfo='TOURISM.OUT';
   maxN=10000;
   NN=10000;

type
   mangR=array[0..maxN] of real;
   mangI=array[0..maxN] of integer;

var
   fi,fo: text;
   N: integer;
   P: Real;
   a: mangR;
   x: ^mangR;
   Tr: ^mangI;
   S: real;
   slkq: integer;
   kq: ^mangI;

procedure Docdl;
var i: integer;
begin
   readln(fi,N);
   readln(fi,P);
   for i:=1 to N do read(fi,a[i]);
end;

procedure XDB;
var i,j: integer;
begin
   x^[0]:=0; tr^[0]:=-1;
   for i:=1 to N do
      begin
         x^[i]:=x^[i-1]+sqr(a[i]-a[i-1]-p);
         tr^[i]:=i-1;
         for j:=i-2 downto 0 do
            begin
               if sqr(a[i]-a[j]-p)>x^[i] then break;
               if x^[i]>x^[j]+sqr(a[i]-a[j]-p) then
                  begin
                     x^[i]:=x^[j]+sqr(a[i]-a[j]-p);
                     tr^[i]:=j;
                  end;
            end;
      end;
end;

procedure XLB;
var u: integer;
begin
   S:=x^[N];
   slkq:=0;
   u:=N;
   repeat
      inc(slkq);
      kq^[slkq]:=u;
      u:=tr^[u];
   until u=0;
end;

procedure Inkq;
var i: integer;
begin
   writeln(fo,S:0:0);
   writeln(fo,slkq);
   for i:=slkq downto 1 do write(fo,kq^[i],' ');
end;

procedure SinhDL;
var ch: char;
    i: integer;
begin
   clrscr;
   write('Ban co tao file ',tfi,' (C/K)?');
   repeat ch:=readkey until upcase(ch) in ['C','K'];
   if upcase(ch)='K' then exit;
   randomize;
   N:=NN;
   P:=random(500);
   a[0]:=0;
   for i:=1 to N do a[i]:=a[i-1]+random(trunc(P))+1;
   assign(fi,tfi); rewrite(fi);
   writeln(fi,N);
   writeln(fi,P:0:0);
   for i:=1 to N do write(fi,a[i]:0:0,' ');
   close(fi);
end;

BEGIN
   {sinhDL;}
   assign(fi,tfi); reset(fi);
   assign(fo,tfo); rewrite(fo);
   Docdl;
   new(x); new(tr); new(kq);
   XDB;
   XLB;
   Inkq;
   dispose(x);
   dispose(kq);
   dispose(tr);
   close(fi); close(fo);
END.