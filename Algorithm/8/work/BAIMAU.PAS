{*********************************************************************
* Program     :   LAM VIEC TAP THE (WORK- Version 1.0)               *
* Date        :   12-01-2006                                         *
* Group       :   Qui hoach dong                                     *
*********************************************************************}
{$R+}
const
   tfi                  =     'WORK.IN';
   tfo                  =     'WORK.OUT';
   maxN                 =      10001;

type
   mang1                =     array[1..maxN] of longint;

var
   fi, fo               :     text;
   N                    :     integer;
   a,b                  :     ^mang1;

   f                    :     mang1;
   Ds                   :     longint;

procedure capphat;
begin
   new(a);
   new(b);
end;

procedure Docdl;
var i: integer;
begin
   assign(fi,tfi); reset(fi);
   read(fi,N);
   for i:=1 to N do read(fi,a^[i],b^[i]);
   close(fi);
end;

procedure Trao(var u,v: longint);
var w: longint;
begin
   w:=u;
   u:=v;
   v:=w;
end;

procedure sortA(k,l: integer);
var r: longint;
    i,j: integer;
begin
   r:=a^[(k+l) div 2];
   i:=k;
   j:=l;
   repeat
      while a^[i]<r do inc(i);
      while a^[j]>r do dec(j);
      if i<=j then
         begin
            Trao(a^[i],a^[j]);
            Trao(b^[i],b^[j]);
            inc(i);
            dec(j);
         end;
   until i>j;
   if k<j then sortA(k,j);
   if i<l then sortA(i,l);
end;

procedure Tinh;
var i,j: integer;
    max1,max2: longint;
begin
   sortA(1,n);
   f[1]:=b^[1]-a^[1];
   Ds:=f[1];
   for i:=2 to N do
      begin
         max1:=b^[i]-a^[i];
         max2:=-maxlongint;
         for j:=i-1 downto 1 do
            begin
               if (b^[j]<=a^[i]) and (max1<f[j]+b^[i]-a^[i]) then
                  max1:=f[j]+b^[i]-a^[i];
               if (b^[j]>=a^[i]) and (b^[j]<=b^[i])
               and (max2<f[j]+b^[i]-b^[j]-(b^[j]-a^[i])) then
                  max2:=f[j]+(b^[i]-b^[j])-(b^[j]-a^[i]);
            end;
         f[i]:=max1;
         if f[i]<max2 then f[i]:=max2;
         if f[i]>Ds then Ds:=f[i];
      end;
end;

procedure Inkq;
begin
   assign(fo,tfo); rewrite(fo);
   writeln(fo,Ds);
   close(fo);
end;

BEGIN
   capphat;
   Docdl;
   Tinh;
   Inkq;
END.