{*********************************************************************
*   Program    :    Cua hang ban hoa (FLOWER)                        *
*   Date       :    21-3-2006                                        *
*   Group      :    Qui hoach dong                                   *
*********************************************************************}
{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}
uses crt;

const
   tfi='FLOWER.INP';
   tfo='FLOWER.OUT';
   maxMN=100;
   MM=53;
   NN=100;

var
   fi,fo: text;
   m,n: integer;
   a: array[1..maxMN,1..maxMN] of integer;
   x: array[1..maxMN,1..maxMN] of integer;
   tr: array[1..maxMN,1..maxMN] of integer;
   kq: array[1..maxMN] of integer;

procedure Docdl;
var i,j: integer;
begin
   readln(fi,m,n);
   for i:=1 to m do
      begin
         for j:=1 to N do read(fi,a[i,j]);
         readln(fi);
      end;
end;

procedure XDB;
var i,j,k: integer;
begin
   for j:=1 to N do
      x[1,j]:=a[1,j]; Tr[1,j]:=0;
   for i:=2 to m do
      for j:=i to n do
         begin
            x[i,j]:=a[i,j]+x[i-1,j-1];
            tr[i,j]:=j-1;
            for k:=j-2 downto i-1 do
               if x[i,j]<a[i,j]+x[i-1,k] then
                  begin
                     x[i,j]:=a[i,j]+x[i-1,k];
                     tr[i,j]:=k;
                  end;
         end;
end;

procedure XLB;
var u,i: integer;
begin
   u:=m;
   for i:=m+1 to n do
      if x[m,i]>x[m,u] then u:=i;
   for i:=m downto 1 do
      begin
         kq[i]:=u;
         u:=Tr[i,u];
      end;
end;

procedure Inkq;
var i: integer;
begin
   writeln(fo,x[m,kq[m]]);
   for i:=1 to m do write(fo,kq[i],' ');
end;

procedure SinhDL;
var ch: char;
    i,j: integer;
begin
   clrscr;
   write('Ban co muon tao file ',tfi,' (C/K)?');
   repeat ch:=readkey until upcase(ch) in ['C','K'];
   if upcase(ch)='K' then exit;
   randomize;
   M:=MM;
   N:=NN;
   for i:=1 to M do
      for j:=1 to N do a[i,j]:=50-random(100);
   assign(fi,tfi); rewrite(fi);
   writeln(fi,M,' ',N);
   for i:=1 to M do
      begin
         for j:=1 to N do write(fi,a[i,j],' ');
         writeln(fi);
      end;
   close(fi);
end;

BEGIN
   {sinhDL;}
   assign(fi,tfi); reset(fi);
   assign(fo,tfo); rewrite(fo);
   Docdl;
   XDB;
   XLB;
   Inkq;
   close(fi); close(fo);
END.