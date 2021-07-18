{$R-}
const
   tfi                  =     'NIMGAME.INP';
   tfo                  =     'NIMGAME.OUT';
   maxN                 =     100;

var
   fi, fo               :     text;
   N,M                  :     integer;
   b                    :     array[0..maxN] of byte;
   a                    :     array[0..maxN,0..maxN] of byte;

procedure Docdl;
begin
   assign(fi,tfi); reset(fi);
   read(fi,N,M);
   close(fi);
end;

function Tinh(k,u,v: integer): integer;
var i,T: integer;
begin
   if a[u,v]<>101 then
      begin
         Tinh:=a[u,v];
         exit;
      end;
   if k=0 then
      begin
         a[u,v]:=b[u];
         Tinh:=a[u,v];
         exit;
      end;
   a[u,v]:=0;
   for i:=1 to m do
      begin
         if i>k then break;
         T:=k+u+v-Tinh(k-i,v,u+i);
         if T>a[u,v] then a[u,v]:=T;
      end;
   Tinh:=a[u,v];
end;

procedure Solve;
var k: integer;
begin
   b[0]:=0;
   for k:=1 to n do
      begin
         fillchar(a,sizeof(a),101);
         b[k]:=Tinh(k,0,0);
      end;
end;

procedure Inkq;
begin
   assign(fo,tfo); rewrite(fo);
   writeln(fo,b[n]);
   close(fo);
end;

BEGIN
   Docdl;
   Solve;
   Inkq;
END.