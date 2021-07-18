{$R-}
const
   tfi                  =     'MUSIC.INP';
   tfo                  =     'MUSIC.OUT';
   maxN                 =     1000;
   maxB                 =     126;

type
   BanNhac              =     record T,Z,Name: integer end;
   mang                 =     array[0..maxB] of byte;

var
   fi, fo               :     text;
   N,P                  :     integer;
   a                    :     array[1..maxN] of BanNhac;

   F                    :     array[0..maxN] of longint;
   kt                   :     integer;

   Tr                   :     array[0..maxN] of ^mang;

   slx                  :     integer;
   x                    :     array[1..maxN] of integer;

procedure CapPhat;
var i: integer;
begin
   for i:=0 to maxN do
      new(Tr[i]);
end;

procedure SetBit(i,j: integer);
var u,v: integer;
begin
   u:=j div 8;
   v:=j mod 8;
   (* Bat bit thu v cua Tr[i,u] *)
   Tr[i]^[u]:=Tr[i]^[u] or (1 shl v);
end;

function GetBit(i,j: integer): byte;
var u,v: integer;
begin
   u:=j div 8;
   v:=j mod 8;
   (* kiem tra bit thu v cua Tr[i,u] *)
   GetBit:=(Tr[i]^[u] and (1 shl v)) shr v;
end;

procedure Docdl;
var i: integer;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,N,P);
   for i:=1 to N do read(fi,a[i].T);
   readln(fi);
   for i:=1 to N do read(fi,a[i].Z);
   close(fi);
   for i:=1 to N do a[i].Name:=i;
end;

procedure Trao(var u,v: BanNhac);
var w: BanNhac;
begin
   w:=u;
   u:=v;
   v:=w;
end;

procedure SapXep;
var i,j: integer;
begin
   for i:=1 to N-1 do
      for j:=i+1 to N do
         if a[i].T>a[j].T then
            Trao(a[i],a[j]);
end;

procedure Solve;
var k,i,j,u,v: integer;
begin
   for i:=0 to maxN do
      for j:=maxB downto 0 do Tr[i]^[j]:=0;
   SapXep;
   for k:=1 to N do F[k]:=0; {Phan thuong khi khong xem}
   for k:=1 to N do
      begin
         F[k]:=-1; {Khong xac dinh}
         if (a[k].T>=k*P) and (F[k-1]<>-1) then
            begin
               SetBit(k,k);{Tr[k,k]:=1;}
               F[k]:=F[k-1]+a[k].z;
            end;
         for i:=k-1 downto 1 do
            if (a[k].T>=i*P) and (F[i-1]+a[k].z>F[i]) then
               begin
                   F[i]:=F[i-1]+a[k].z;
                   SetBit(k,i);{Tr[k,i]:=1;}
               end;
      end;
   (* Tim diem ket thuc *)
   kt:=0;
   for i:=1 to N do
      if F[i]>F[kt] then kt:=i;
   slx:=0;
   if F[kt]=0 then exit;
   u:=N;
   v:=kt;
   repeat
      if GetBit(u,v)=1 then
         begin
            inc(slx);
            x[slx]:=a[u].name;
            dec(u);
            dec(v);
         end
      else dec(u);
   until (u=0) or (v=0);
end;

procedure Inkq;
var i: integer;
begin
   assign(fo,tfo); rewrite(fo);
   writeln(fo,F[kt]);
   for i:=slx downto 1 do write(fo,x[i],' ');
   close(fo);
end;

BEGIN
   CapPhat;
   Docdl;
   Solve;
   Inkq;
END.