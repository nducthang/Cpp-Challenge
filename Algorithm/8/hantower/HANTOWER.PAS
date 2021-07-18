const
   tfi                  =       'HANTOWER.INP';
   tfo                  =       'HANTOWER.OUT';
   maxN                 =       30;
   maxM                 =       30;

var
   fi,fo                :       text;
   N,M                  :       integer;

   f                    :       array[1..maxN,3..maxM] of extended;


procedure Tinh;
var i,j,k: integer;
begin
   {Tinh khi m=3: f[n,3]=2f[n-1,3]+1}
   f[1,3]:=1;
   for i:=2 to N do f[i,3]:=2*f[i-1,3]+1;

   {f[n,m]=min(2*f[k,m]+f[n-k,m-1]}
   for j:=4 to m do
      begin
         f[1,j]:=1;
         for i:=2 to N do
            begin
               f[i,j]:=2*f[1,j]+f[i-1,j-1];
               for k:=2 to i-1 do
                  if f[i,j]>2*f[k,j]+f[i-k,j-1] then
                     f[i,j]:=2*f[k,j]+f[i-k,j-1];
            end;
      end;
end;


BEGIN
   assign(fi,tfi); reset(fi);
   assign(fo,tfo); rewrite(fo);
   while not seekeof(fi) do
      begin
         readln(fi,N,M);
         Tinh;
         writeln(fo,f[n,m]:0:0);
      end;
   close(fi); close(fo);
END.