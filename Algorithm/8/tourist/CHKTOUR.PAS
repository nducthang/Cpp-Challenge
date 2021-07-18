uses crt;

const
   kq: array[0..9] of integer=(2952,2013,709,892,1045,1132,1675,1904,1939,2004);

var k: integer;
    tfi,tfo: string[12];
    fi,fo: text;
    N: integer;
    c: array[1..100,1..100] of integer;
    S: integer;
    x: array[1..101] of integer;
    ok,nofile: boolean;
    check: array[0..9] of boolean;

procedure Docdl;
var i,j: integer;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,N);
   for i:=1 to N do
      begin
         for j:=1 to N do read(fi,c[i,j]);
         readln(fi);
      end;
   close(fi);
end;

procedure Dockq;
var i: integer;
begin
   {$I-}
   assign(fo,tfo); reset(fo);
   if IOResult<>0 then
      begin
         nofile:=true;
         {$I+}
         exit;
      end;
   {$I+}
   nofile:=false;
   readln(fo,S);
   for i:=1 to N+1 do read(fo,x[i]);
   close(fo);
   erase(fo);
end;

procedure PhanTich;
var i: integer;
    dd: array[1..100] of byte;
    T: integer;
begin
   ok:=false;
   if nofile then exit;
   if S>kq[k] then exit;
   {kiem tra Bac - Nam}
   if x[1]<>1 then exit;
   i:=1;
   while (i<N+1) and (x[i+1]>x[i]) do inc(i);
   if (i=1) or (i=N+1) then exit;
   if x[i]<>N then exit;
   while (i<N+1) and (x[i+1]<x[i]) do inc(i);
   if i<N+1 then exit;
   if x[N+1]<>1 then exit;
   {Kiem tra moi dinh 1 lan}
   fillchar(dd,sizeof(dd),0);
   dd[1]:=1;
   for i:=2 to N do
      begin
         if dd[x[i]]=1 then exit;
         dd[x[i]]:=1;
      end;
   {Kiem tra S=T}
   T:=0;
   for i:=2 to N+1 do
      T:=T+c[x[i-1],x[i]];
   if T<>S then exit;
   ok:=true;
end;

procedure Inkq;
var count,i,l,diem: integer;
begin
   clrscr;
   writeln;
   writeln;
   writeln;
   writeln('                 *************************************************');
   writeln('                 *        KET QUA CHAM BAI DU LICH XUYEN VIET    *');
   writeln('                 *************************************************');
   count:=0;
   for l:=1 to 10 do
      begin
         i:=l mod 10;
         write('                  TEST SO:',i,':');
         if check[i] then diem:=1 else diem:=0;
         count:=count+diem;
         writeln(' ',diem,' diem');
      end;
   writeln('                  -------------------------------------------------');
   writeln('                   Tong cong la:',count,' diem');
   writeln;
   writeln('Bam phim bat ky de ket thuc...');
   repeat until keypressed;
end;

BEGIN
   for k:=0 to 9 do
      begin
         tfi:='TOURIST.IN'+chr(k+48);
         tfo:='TOURIST.OU'+chr(k+48);
         Docdl;
         Dockq;
         PhanTich;
         check[k]:=ok;
      end;
   Inkq;
END.