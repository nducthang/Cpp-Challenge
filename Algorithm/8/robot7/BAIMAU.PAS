{*********************************************************************
* Program       :     TIM CAC TRANG THAI KHAC NHAU CUA ROBOT         *
* Date          :     19-11-2005                                     *
* Thuat toan    :     QUI HOACH DONG                                 *
*********************************************************************}
{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
const
   tfi='ROBOT.INP';
   tfo='ROBOT.OUT';
   maxN=80;

var
   fi, fo: text;
   N: longint;
   a: array[1..maxN,1..maxN] of longint;
   tr: array[1..maxN,1..maxN] of byte;
   sol: integer;
   x: array[1..maxN] of integer;
   kq: longint;

procedure Docdl;
begin
  assign(fi,tfi); reset(fi);
  readln(fi,N);
  close(fi);
end;

function BSCNN(u,v: longint): longint;
var p,q,r:longint;
begin
   p:=u; q:=v;
   repeat
      r:=p mod q;
      if r>0 then
         begin
            p:=q;
            q:=r;
         end;
   until r=0;
   BSCNN:=(u div q)*v;
end;

function Tinh(n,m: longint): longint;
var j,T: longint;
begin
   if a[n,m]<>0 then
      begin
         Tinh:=a[n,m];
         exit;
      end;
   if n=m then
      begin
         a[n,m]:=m;
         tr[n,m]:=0;
         Tinh:=m;
         exit;
      end;
   j:=1;
   while (n-m>=j) and (j<=m) do
      begin
         T:=Tinh(n-m,j);
         T:=BSCNN(T,m);
         if T>a[n,m] then
            begin
               a[n,m]:=T;
               Tr[n,m]:=j;
            end;
         inc(j);
      end;
   Tinh:=a[n,m];
end;

procedure XDB;
var i,j: integer;
begin
   for i:=1 to N do
      for j:=1 to i do a[i,j]:=0;
   for i:=1 to N do a[N,i]:=Tinh(N,i);
end;

procedure XLB;
var p,u,i,u1: longint;
begin
   u:=1;
   for i:=2 to N do
      if a[n,i]>a[n,u] then u:=i;
   kq:=a[n,u];
   sol:=0;
   p:=N;
   while p>0 do
      begin
         inc(sol);
         x[sol]:=u;
         u1:=Tr[p,u];
         p:=p-u;
         u:=u1;
      end;
end;

procedure Inkq;
var dau,cuoi,i,j: longint;
begin
   assign(fo,tfo); rewrite(fo);
   writeln(fo,kq);
   cuoi:=0;
   for i:=1 to sol do
      begin
         dau:=cuoi+1;
         cuoi:=cuoi+x[i];
         for j:=dau+1 to cuoi do write(fo,j,#32);
         write(fo,dau,#32);
      end;
   close(fo);
end;


BEGIN
   Docdl;
   XDB;
   XLB;
   Inkq;
END.