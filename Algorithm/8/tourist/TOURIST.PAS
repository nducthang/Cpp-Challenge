{*********************************************************************
                          HANH TRINH XUYEN VIET
*********************************************************************}
{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
uses crt;

const
   tfi='TOURIST.INP';
   tfo='TOURIST.OUT';
   maxN=100;

var
   fi,fo                        :       text;
   c                            :       array[0..maxN,0..maxN] of integer;
   N                            :       integer;
   a                            :       array[0..maxN,0..maxN] of integer;
   Tr                           :       array[0..maxN,0..maxN] of integer;
   count                        :       integer;
   x                            :       array[1..maxN+1] of integer;
   dd                           :       array[0..maxN] of integer;
   S                            :       integer;

procedure Docdl;
var i,j: integer;
begin
   fillchar(c,sizeof(c),0);
   readln(fi,N);
   for i:=1 to N do
      begin
         for j:=1 to N do read(fi,c[i,j]);
         readln(fi);
      end;
   for i:=1 to N do c[0,i]:=c[1,i];
   for i:=1 to N do c[i,0]:=c[i,1];
end;

function Tinh(i,j: integer): integer;
var k,l: integer;
    T: integer;
begin
   if a[i,j]>=0 then
      begin
         Tinh:=a[i,j];
         exit;
      end;
   if i=N then
      begin
         a[i,j]:=c[n,j];
         Tinh:=a[i,j];
         exit;
      end;
   a[i,j]:=c[i,i+1]+Tinh(i+1,j);
   Tr[i,j]:=i+1;
   for k:=i+2 to N do
      begin
         T:=c[i,k]+Tinh(k,k-1);
         for l:=k-1 downto i+2 do T:=T+c[l,l-1];
         T:=T+c[i+1,j];
         if T<a[i,j] then
            begin
               a[i,j]:=T;
               Tr[i,j]:=k;
            end;
      end;
   Tinh:=a[i,j];
end;

procedure XDB;
var i,j: integer;
begin
   for i:=0 to N do
      for j:=0 to N do a[i,j]:=-1;
   Tinh(1,0);
end;

procedure Next(i,j: integer);
var k: integer;
begin
   k:=Tr[i,j];
   inc(count);
   x[count]:=k;
   dd[k]:=1;
   if k=N then exit;
   if k=i+1 then Next(i+1,j)
            else Next(k,k-1);
end;

procedure XLB;
var i: integer;
begin
   count:=1; x[1]:=1;
   fillchar(dd,sizeof(dd),0);
   dd[1]:=1;
   Next(1,0);
   for i:=N downto 0 do
      if dd[i]=0 then
         begin
            inc(count);
            x[count]:=i;
            if i=0 then x[count]:=1;
         end;
   S:=0;
   for i:=2 to N+1 do S:=S+c[x[i-1],x[i]];
end;

procedure Inkq;
var i: integer;
begin
   writeln(fo,S);
   for i:=1 to N+1 do write(fo,x[i],' ');
end;

BEGIN
   assign(fi,tfi); reset(fi);
   assign(fo,tfo); rewrite(fo);
   Docdl;
   XDB;
   XLB;
   Inkq;
   close(fi); close(fo);
END.