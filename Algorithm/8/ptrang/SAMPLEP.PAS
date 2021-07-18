{*************************************************************************
Program   :    PHAN TRANG - (PTRANG)
Date      :    29-3-2007
Langues   :    Free Pascal
*************************************************************************}

const
   tfi='PTRANG.INP';
   tfo='PTRANG.OUT';
   maxn = 4001;

var
   fi, fo: text;
   sl,N,L: integer;
   x,w,f,prev: array[0..maxn] of integer;

procedure Doc;
var i: integer;
begin
   assign(fi,tfi); reset(fi);
   read(fi,N,L);
   for i:=1 to n do read(fi,w[i]);
   close(fi);
end;

function max(u,v: integer): integer;
begin
   if u<v then max:=v else max:=u;
end;

procedure Tinh;
var i,k: integer;
    T: integer;
begin
   f[0]:=0; prev[0]:=-1;
   for i:=1 to n do
   begin
      f[i]:=L+1; prev[i]:=-1;
      T:=w[i];
      k:=i-1;
      while (k>=0) and (T<=L) do
      begin
         if f[i]>max(f[k],(L-T)) then
         begin
            f[i]:=max(f[k],(L-T));
            prev[i]:=k;
         end;
         T:=T+w[k];
         dec(k);
      end;
   end;
end;

procedure Tim;
var u: integer;
begin
   u:=n;
   sl:=0;
   while u>0 do
   begin
      inc(sl);
      x[sl]:=u;
      u:=prev[u];
   end;
end;

procedure Viet;
var i, dau, cuoi, j: integer;
begin
   assign(fo,tfo); rewrite(fo);
   writeln(fo,f[n],' ',sl);
   dau:=1;
   for i:=sl downto 1 do
   begin
      cuoi:=x[i];
      for j:=dau to cuoi do write(fo,j,' ');
      writeln(fo);
      dau:=cuoi+1;
   end;
   close(fo);
end;

BEGIN
   Doc;
   Tinh;
   Tim;
   Viet;
END.
