const
   tfi               =     'CHANGEST.INP';
   tfo               =     'CHANGEST.OUT';
   maxN              =     100;

var
 fi, fo              :     text;
 x, y                :     string;
 N, M                :     integer;

 L                   :     array[0..maxN,0..maxN] of integer;

 sl                  :     integer;
 a,b,kieu            :     array[1..maxN] of integer;
 c                   :     array[1..maxN] of char;

procedure Docdl;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,x);
   readln(fi,y);
   N:=length(x);
   M:=length(y);
   close(fi);
end;

procedure Tinh;
var i,j: integer;
begin
   for j:=1 to N do L[0,j]:=j;
   for i:=0 to M do L[i,0]:=i;
   for i:=1 to M do
      for j:=1 to N do
         if x[j]=y[i] then L[i,j]:=L[i-1,j-1] else
            begin
               L[i,j]:=L[i,j-1]+1;
               if L[i,j]>L[i-1,j]+1 then L[i,j]:=L[i-1,j]+1;
               if L[i,j]>L[i-1,j-1]+1 then L[i,j]:=L[i-1,j-1]+1;
            end;
end;

procedure Tim;
var u,v: integer;
begin
   sl:=0;
   u:=M;
   v:=N;
   repeat
      if y[u]=x[v] then
         begin
            dec(u);
            dec(v);
         end
      else
         begin
            inc(sl);
            if (u>=1) and (L[u,v]=L[u-1,v]+1) then (* chen *)
               begin
                  a[sl]:=v;
                  b[sl]:=u;
                  c[sl]:=y[u];
                  kieu[sl]:=1;
                  dec(u);
               end
            else if (v>=1) and (L[u,v]=L[u,v-1]+1) then (* xoa *)
               begin
                  a[sl]:=v;
                  b[sl]:=u;
                  c[sl]:=y[u];
                  kieu[sl]:=2;
                  dec(v);
               end
            else
               begin
                  a[sl]:=v;
                  b[sl]:=u;
                  c[sl]:=y[u];
                  kieu[sl]:=3;
                  dec(u);
                  dec(v);
               end;
         end;
   until (u=0) and (v=0);
end;

procedure Inkq;
var i: integer;
begin
   assign(fo,tfo); rewrite(fo);
   writeln(fo,sl);
   for i:=sl downto 1 do
      case kieu[i] of
         1: writeln(fo,'I ',b[i],' ',c[i]);
         2: writeln(fo,'D ',b[i]+1);
         3: writeln(fo,'R ',b[i],' ',c[i]);
      end;
   close(fo);
end;

BEGIN
   Docdl;
   Tinh;
   Tim;
   Inkq;
END.