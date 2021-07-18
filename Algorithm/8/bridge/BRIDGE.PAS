const
   tfi='BRIDGE.INP';
   tfo='BRIDGE.OUT';

type
   xaukt=string[101];

var
   fi, fo: text;
   mau: xaukt;
   s: array[1..2] of xaukt;
   M,N: integer;
   a: array[0..100,0..100,1..2] of integer;
   kq: integer;

procedure Docdl;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,mau);
   readln(fi,s[1]);
   readln(fi,s[2]);
   close(fi);
end;

procedure XDB;
var l,i,j: integer;
begin
   m:=length(mau);
   n:=length(s[1]);
   fillchar(a,sizeof(a),0);
   for i:=0 to m do
      begin
         a[i,0,1]:=1;
         a[i,0,2]:=1;
      end;
   for j:=1 to N do
      for i:=j downto 1 do
         begin
            if s[1][j]=mau[i] then
               for l:=j-1 downto i-1 do a[i,j,1]:=a[i,j,1]+a[i-1,l,2];
            if s[2][j]=mau[i] then
               for l:=j-1 downto i-1 do a[i,j,2]:=a[i,j,2]+a[i-1,l,2];
         end;
end;

procedure XLB;
var i: integer;
begin
   kq:=0;
   for i:=m to n do
      kq:=kq+a[m,i,1]+a[m,i,2];
end;

procedure Inkq;
begin
   assign(fo,tfo); rewrite(fo);
   writeln(fo,kq);
   close(fo);
end;

BEGIN
   Docdl;
   XDB;
   XLB;
   Inkq;
END.