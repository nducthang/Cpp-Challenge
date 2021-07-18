{$r-}
const
   tfi='Muadat.inp';
   tfo='Muadat.out';
   maxN=60000;
   maxD=30002;

type
   mang1=array[1..maxD] of word;
   mang2=array[0..maxN] of byte;

var
   fi, fo: text;
   N: word;

   M: integer;
   t: mang2;
   d: array[1..2] of ^mang1;

   slx: integer;
   x: array[1..1000] of byte;

procedure capphat;
var i: integer;
begin
   for i:=1 to 2 do new(d[i]);
end;

function row(p: word): word;
begin
   row:=p div maxD+1;
end;

function col(p: word): word;
begin
   col:=p mod maxD+1;
end;

procedure Doc;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,N);
   close(fi);
   M:=244;
end;

procedure Tinh;
var j,i: word;
begin
   for j:=0 to N do
      begin
         d[row(j)]^[col(j)]:=j;
         t[j]:=1;
      end;
   for i:=2 to M do
      for j:=N downto i*i do
         if d[row(j)]^[col(j)]>d[row(j-i*i)]^[col(j-i*i)]+1 then
            begin
               d[row(j)]^[col(j)]:=d[row(j-i*i)]^[col(j-i*i)]+1;
               t[j]:=i;
            end;
end;

procedure Tim;
var u,v: word;
begin
   fillchar(x,sizeof(x),0);
   u:=N;
   repeat
      inc(x[t[u]]);
      v:=t[u];
      u:=u-v*v;
   until u=0;
end;

procedure Viet;
var i,j: word;
begin
   assign(fo,tfo); rewrite(fo);
   for i:=M downto 1 do
      for j:=x[i] downto 1 do write(fo,i,' ');
   close(fo);
end;

BEGIN
   Capphat;
   Doc;
   Tinh;
   Tim;
   viet;
END.