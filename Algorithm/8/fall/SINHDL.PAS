const
   NN=1000;
   M=1000;
   tfi='FALL.IN0987654321';

type
   van = record x1, x2, h: integer end;

var
   a: array[1..1000] of van;
   name: array[1..1000] of integer;
   N: integer;

   x,y: integer;

procedure TraoVan(var u,v: Van);
var w: Van;
begin
   w:=u;
   u:=v;
   v:=w;
end;

procedure TraoTen(var u,v: integer);
var w: integer;
begin
   w:=u;
   u:=v;
   v:=w;
end;

procedure sort(k,l: integer);
var r,i,j: integer;
begin
   r:=(k+l) div 2;
   i:=k;
   j:=l;
   repeat
      while a[i].h>a[r].h do inc(i);
      while a[j].h<a[r].h do dec(j);
      if i<=j then
         begin
            TraoVan(a[i],a[j]);
            inc(i); dec(j);
         end;
   until i>j;
   if k<j then Sort(k,j);
   if i<l then Sort(i,l);
end;

function Trung(i: integer): boolean;
var j: integer;
begin
   Trung:=true;
   for j:=i-1 downto 1 do
      if (a[j].h=a[i].h) and
         (((a[j].x1<=a[i].x1) and (a[i].x1<=a[j].x2)) or
          ((a[j].x1<=a[i].x2) and (a[i].x2<=a[j].x2))) then exit;
   Trung:=false;
end;

function ChuaCo(y: integer): boolean;
var i: integer;
begin
   ChuaCo:=false;
   for i:=1 to N do
      if a[i].h=y then exit;
   ChuaCo:=true;
end;

procedure Taodl;
var i,j: integer;
begin
   for i:=1 to N do
      with a[i] do
         begin
            x1:=random(200);
            x1:=x1-100;
            x2:=random(100);
            x2:=x2+x1+1;
            h:=random(10000);
         end;
   Sort(1,N);
   i:=1;
   while i<=N do
      begin
         while Trung(i) do
            begin
               for j:=i to N-1 do a[j]:=a[j+1];
               dec(N);
            end;
         inc(i);
      end;
   x:=random(200);
   x:=x-100;
   repeat y:=random(10000) until ChuaCo(y);
   for i:=1 to N do name[i]:=i;
   for i:=N downto 2 do
      begin
         j:=random(i)+1;
         TraoTen(name[i],name[j]);
      end;

end;

procedure Inkq;
var fi: text;
    i: integer;
begin
   assign(fi,tfi); rewrite(fi);
   writeln(fi,N,' ',x,' ',y,' ',M);
   for i:=1 to N do
      with a[name[i]] do
         writeln(fi,x1,' ',x2,' ',h);
   close(fi);
end;

BEGIN
   N:=NN;
   randomize;
   Taodl;
   Inkq;
END.