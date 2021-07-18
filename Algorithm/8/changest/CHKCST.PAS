{$A+,B-,D+,E+,F-,G-,I-,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt,dos;

const
    dtfi='CHANGEST.IN';
    dtfo='CHANGEST.OU';
    dtfm='CHANGEST.AN';
    kqm: array[0..9] of integer=(88,10,16,31,38,44,60,66,74,86);

var
   Error: array[0..9] of integer;
   Diem: array[0..9] of real;
   p: integer;
   tfi,tfo,tfm: string[12];
   d: SearchRec;
   fi,fo,fm: text;

   x,y: string;
   N,M: integer;

   st: string;

procedure Docdl;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,x);
   readln(fi,y);
   N:=length(x);
   M:=length(y);
   close(fi);
end;

procedure Doc(var kieu,vitri: integer; var kytu: char);
var c: char;
begin
   read(fo,c);
   kieu:=pos(c,'IDR');
   case kieu of
      1: begin
            read(fo,vitri);
            repeat read(fo,kytu) until kytu<>#32;
         end;
      2: read(fo,vitri);
      3: begin
            read(fo,vitri);
            repeat read(fo,kytu) until kytu<>#32;
         end;
   end;
   readln(fo);
end;

procedure Cham;
var kqo,i, kieu, vitri: integer;
    kytu: char;
begin
   readln(fo,kqo);
   for i:=1 to kqo do
      begin
         Doc(kieu,vitri,kytu);
         case kieu of
            0: begin
                  error[p]:=3; {pheps BD khong hop le}
                  exit;
               end;
            1: begin
                  if (vitri<1) or (vitri>length(x)+1) then
                     begin
                        error[p]:=4; {chen khong hop le}
                        exit;
                     end;
                  insert(kytu,x,vitri);
               end;
            2: begin
                  if (vitri<1) or (vitri>length(x)) then
                     begin
                        error[p]:=5; {xoa khong hop le}
                        exit;
                     end;
                  delete(x,vitri,1);
               end;
            3: begin
                  if (vitri<1) or (vitri>length(x)) then
                     begin
                        error[p]:=6; {doi KT khong hop le}
                        exit;
                     end;
                  x[vitri]:=kytu;
               end;
         end;
      end;
   if x<>y then
      begin
         error[p]:=7; {BD khong thanh xau Y}
         exit;
      end;
   if kqo>kqm[p] then
      begin
         error[p]:=8; {Ket qua khong toi uu}
         diem[p]:=0.5;
         exit;
      end;
   diem[p]:=1.0;
end;

procedure InError(p: LongInt);
begin
   textcolor(red);
   case Error[p] of
      0: writeln;
      1: writeln('Khong co file OUTPUT');
      2: writeln('Loi doc file OUTPUT');
      3: writeln('phep BD khong hop le');
      4: writeln('chen khong hop le');
      5: writeln('xoa khong hop le');
      6: writeln('doi KT khong hop le');
      7: writeln('BD khong thanh xau Y');
      8: writeln('Ket qua khong toi uu');
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