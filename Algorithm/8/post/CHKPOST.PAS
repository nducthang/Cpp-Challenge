{$A+,B-,D+,E+,F-,G-,I-,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt,dos;

const
    dtfi='POST.IN';
    dtfo='POST.OU';
    dtfm='POST.AS';

var
   Error: array[0..9] of integer;
   Diem: array[0..9] of real;
   p: integer;
   tfi,tfo,tfm: string[12];
   d: SearchRec;
   fi,fo,fm: text;
   N,M: longint;
   a: array[1..300] of longint;
   ST,Smau,Sout: longint;
   x: array[1..30] of longint;
   dd: array[1..300] of byte;

procedure Docdl;
var i: longint;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,N,M);
   for i:=1 to n do read(fi,a[i]);
   close(fi);
   assign(fm,tfm); reset(fm);
   readln(fm,Smau);
   close(fm);
end;

function Thay(u: longint): boolean;
var i: longint;
begin
   for i:=1 to N do
      if a[i]=u then
         begin
            Thay:=true;
            dd[i]:=1;
            exit;
         end;
   Thay:=false;
end;

function KhoangCach(i: longint): longint;
var u,v: longint;
begin
   u:=i;
   while (u>=1) and (dd[u]=0) do dec(u);
   v:=i;
   while (v<=n) and (dd[v]=0) do inc(v);
   if u=0 then KhoangCach:=a[v]-a[i] else
   if v=n+1 then KhoangCach:=a[i]-a[u] else
   if a[v]-a[i]>a[i]-a[u] then KhoangCach:=a[i]-a[u]
                          else KhoangCach:=a[v]-a[i];
end;

procedure Cham;
var i: longint;
begin
   {Phat hien loi file}
   readln(fo,Sout);
   if IOresult<>0 then
      begin
         Error[p]:=2;
         exit;
      end;
   for i:=1 to M do
      begin
         read(fo,x[i]);
         if IOresult<>0 then
            begin
               Error[p]:=2;
               exit;
            end;
         if (i>1) and (x[i]<=x[i-1]) then
            begin
               Error[p]:=3;
               exit;
            end;
      end;
   if not seekeoln(fo) then
      begin
         Error[p]:=3; {in sai qui cach}
         exit;
      end;

   {Kiem tra tinh dung dan cua dat buu cuc}
   fillchar(dd,sizeof(dd),0);
   for i:=1 to M do
      if Not Thay(x[i]) then
         begin
            Error[p]:=4; {khong dat dung lang}
            exit;
         end;
   {Tinh theo phuong an}
   ST:=0;
   for i:=1 to N do
      if dd[i]=0 then
         ST:=ST+KhoangCach(i);
   if ST<>Sout then
      begin
         Error[p]:=5; {Tinh tong SAI}
         exit;
      end;
   {Cham diem}
   if Sout<=Smau then diem[p]:=1.0 else Diem[p]:=int(Smau/Sout*10)/10;
end;

procedure InError(p: LongInt);
begin
   textcolor(red);
   case Error[p] of
      0: writeln;
      1: writeln('Khong co file OUTPUT');
      2: writeln('Loi doc file OUTPUT');
      3: writeln('In sau qui cach');
      4: writeln('Khong dat dung lang');
      5: writeln('Tinh tong sai');
   end;
   textcolor(white);
end;

procedure Inkq;
var T: real;
begin
   clrscr;
   writeln;
   writeln;
   writeln;
   textcolor(white);
   writeln('         ********************************************************');
   writeln('         *          Ket qua cham bai BUU CUC (IOI 2000)         *');
   writeln('         ********************************************************');
   T:=0.0;
   for p:=0 to 9 do
      begin
         write('              TEST ',p,': ',Diem[p]:4:1,' Diem.');
         InError(p);
         T:=T+diem[p];
      end;
   writeln('          --------------------------------------------------------');
   textcolor(green);
   writeln('          Tong cong = ',T:4:1,' Diem');
   textcolor(white);
end;

procedure XoaFile;
begin
   for p:=0 to 9 do
      begin
         tfo:=dtfo+chr(p+48);
         FindFirst(tfo,archive,d);
         if DosError<>0 then continue;
         assign(fo,tfo);
         erase(fo);
      end;
end;

BEGIN
   fillchar(Error,sizeof(Error),0);
   fillchar(Diem,sizeof(Diem),0);
   for p:=0 to 9 do
      begin
         tfi:=dtfi+chr(p+48);
         tfm:=dtfm+chr(p+48);
         tfo:=dtfo+chr(p+48);
         FindFirst(tfo,Archive,d);
         if DosError<>0 then
            begin
               Error[p]:=1;
               continue;
            end;
         Docdl;
         assign(fo,tfo); reset(fo);
         Cham;
         close(fo);
      end;
   Inkq;
   XoaFile;
END.