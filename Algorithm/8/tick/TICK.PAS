{**************************************************************************
*                CHUONG TRINH MAU GIAI BAI XEP HANG MUA VE                *
**************************************************************************}
{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
uses crt;

const
   tfi='TICK.INP';
   tfo='TICK.OUT';
   maxN=2000;
   NN=2000;

var
   fi,fo: text;
   N: integer;
   t,r: array[1..maxN] of integer;
   a: array[1..2,1..maxN] of LongInt;
   Tr: array[1..maxN] of byte;
   x: array[1..maxN] of byte;

procedure Docdl;
var i: integer;
begin
   readln(fi,N);
   for i:=1 to N do read(fi,t[i]); readln(fi);
   for i:=1 to N-1 do read(fi,r[i]);
end;

procedure XDB;
var i: integer;
begin
   a[1,1]:=t[1]; a[2,1]:=MaxLongInt;
   Fillchar(Tr,sizeof(Tr),0);
   for i:=2 to N do
      begin
         if a[1,i-1]<a[2,i-1] then
            begin
               a[1,i]:=a[1,i-1]+t[i];
               tr[i]:=1;
            end
         else a[1,i]:=a[2,i-1]+t[i];
         a[2,i]:=a[1,i-1]-t[i-1]+r[i-1]
      end;
end;

procedure XLB;
var i: integer;
begin
   if a[1,N]<a[2,N] then x[n]:=1 else x[n]:=2;
   for i:=n-1 downto 1 do
      begin
         if x[i+1]=2 then x[i]:=1 else
            if Tr[i+1]=1 then x[i]:=1 else x[i]:=2;
      end;
end;

procedure Inkq;
var dem: integer;
    i: integer;
begin
   writeln(fo,a[x[n],n]);
   dem:=0;
   for i:=1 to N do
      if x[i]=2 then
         begin
            inc(dem);
            write(fo,i,' ');
         end;
   if dem=0 then writeln(fo,0);
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
   for i:=1 to N do t[i]:=random(20000);
   for i:=1 to N-1 do r[i]:=t[i]+random(10000);
   assign(fi,tfi); rewrite(fi);
   writeln(fi,N);
   for i:=1 to N do write(fi,t[i],' '); writeln(fi);
   for i:=1 to N-1 do write(fi,r[i],' ');
   close(fi);
end;

BEGIN
   {SinhDL;}
   assign(fi,tfi); reset(fi);
   assign(fo,tfo); rewrite(fo);
   Docdl;
   XDB;
   XLB;
   Inkq;
   close(fi); close(fo);
END.