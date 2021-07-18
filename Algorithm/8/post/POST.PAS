{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}
{*********************************************************************
                             POST OFFICE
*********************************************************************}
uses crt;

const
   tfi='POST.INP';
   tfo='POST.OUT';
   maxV=300;
   maxP=30;

type
   mang=array[1..30] of LongInt;

var
   fi,fo: text;
   V,P: integer;
   d: array[1..maxV] of LongInt;
   a: array[1..maxV] of ^mang;
   Tr: array[1..maxV,1..maxP] of integer;
   S: LongInt;
   x: array[1..maxP] of integer;
   time: longint absolute 0:$046c;
   tsave: longint;

procedure Docdl;
var i: integer;
begin
   readln(fi,V,P);
   for i:=1 to V do read(fi,d[i]);
end;

function min(i,j: LongInt): LongInt;
begin
   if i<j then min:=i else min:=j;
end;

procedure XDB;
var i,j,k,l: integer;
    t: LongInt;
begin
   for i:=1 to maxV do new(a[i]);
   for i:=1 to V do
      begin
         a[i]^[1]:=0; Tr[i,1]:=0;
         for j:=1 to i-1 do a[i]^[1]:=a[i]^[1]+d[i]-d[j];
      end;
   for j:=2 to P do
      begin
         for i:=j to V do
            begin
               a[i]^[j]:=MaxLongInt;
               for k:=i-1 downto j-1 do
                  begin
                     t:=a[k]^[j-1];
                     for l:=k+1 to i-1 do
                        t:=t+min(d[l]-d[k],d[i]-d[l]);
                     if t<a[i]^[j] then
                        begin
                           a[i]^[j]:=t;
                           tr[i,j]:=k;
                        end;
                  end;
            end;
      end;
end;

procedure XLB;
var i,j,u: integer;
    t: LongInt;
begin
   S:=MaxLongInt;
   for i:=P to V do
      begin
         t:=a[i]^[P];
         for j:=i+1 to V do t:=t+d[j]-d[i];
         if t<S then
            begin
               S:=t;
               u:=i;
            end;
      end;
   for i:=P downto 1 do
      begin
         x[i]:=u;
         u:=Tr[u,i];
      end;
end;

procedure Inkq;
var i: integer;
begin
   writeln(fo,S);
   for i:=1 to P do write(fo,d[x[i]],' ');
end;

BEGIN
   Tsave:=time;
   assign(fi,tfi); reset(fi);
   assign(fo,tfo); rewrite(fo);
   Docdl;
   XDB;
   XLB;
   Inkq;
   close(fi); close(fo);
   writeln('Tong thoi gian = ',(time-tsave)/18.3:0:2,' s');
END.