{$A+,B-,D+,E+,F-,G-,I-,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt,dos;

const
    dtfi='MUSIC.IN';
    dtfo='MUSIC.OU';
    dtfm='';
    kqm:array[0..9] of longint=(145459,34979,29272,5985,11836,57732,14905,29811,11958,14887);

type
   BanNhac=record T, Z: integer end;

var
   Error: array[0..9] of integer;
   Diem: array[0..9] of real;
   p: integer;
   tfi,tfo,tfm: string[12];
   d: SearchRec;
   fi,fo,fm: text;

   N,M: integer;
   a: array[1..1000] of BanNhac;

procedure Docdl;
var i: integer;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,N,M);
   for i:=1 to N do read(fi,a[i].T);
   readln(fi);
   for i:=1 to N do read(fi,a[i].z);
   close(fi);
end;

procedure Cham;
var Time,S,kqo,u: longint;
    tyle: real;
begin
   readln(fo,kqo);
   S:=0;
   Time:=0;
   while not seekeoln(fo) do
      begin
         read(fo,u);
         if Time+M>a[u].T then
            begin
               error[p]:=3; {Khong xem het duoc}
               exit;
            end;
         S:=S+a[u].z;
         Time:=Time+M;
      end;
   if S<>Kqo then
      begin
         error[p]:=4; {Tinh tong thuong sai}
         exit;
      end;
   tyle:=kqo/kqm[p];
   if tyle>=1 then diem[p]:=1.0 else
      if tyle>=0.99 then diem[p]:=0.5 else
         if tyle>=0.98 then diem[p]:=0.4 else
            if tyle>=0.97 then diem[p]:=0.3 else
               if tyle>=0.96 then diem[p]:=0.2 else
                  if tyle>=0.95 then diem[p]:=0.1 else
                     begin
                        error[p]:=5; {Thap hon MAU qua 5%}
                        exit;
                     end;
end;

procedure InError(p: LongInt);
begin
   textcolor(red);
   case Error[p] of
      0: writeln;
      1: writeln('Khong co file OUTPUT');
      2: writeln('Loi doc file OUTPUT');
      3: writeln('Khong xem het duoc');
      4: writeln('Tinh tong thuong sai');
      5: writeln('Thap hon MAU qua 5%');
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
   writeln('         *          Ket qua cham bai                            *');
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