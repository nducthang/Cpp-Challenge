{$A+,B-,D+,E+,F-,G-,I-,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt,dos;

const
    dtfi='STEDIT.IN';
    dtfo='STEDIT.OU';
    dtfm='STEDIT.AN';
    kqm: array[0..9] of integer=(91,4,25,32,59,52,69,76,89,65);

var
   Error: array[0..9] of integer;
   Diem: array[0..9] of real;
   p: integer;
   tfi,tfo,tfm: string[12];
   d: SearchRec;
   fi,fo,fm: text;

   S1,S2: string;
   kqo: integer;

procedure Docdl;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,S1);
   readln(fi,S2);
   close(fi);
end;

procedure Cham;
var i, id, vitri, vitri1, vitri2: integer;
    kytu, c: char;
begin
   readln(fo,kqo);
   for i:=1 to kqo do
      begin
         read(fo,id);
         case id of
            1: begin
                  read(fo,vitri);
                  repeat read(fo,kytu) until kytu<>#32;
                  readln(fo);
                  if (vitri<1) or (vitri>length(s1)) then
                     begin
                        error[p]:=3; {Bien doi loai 1 khong hop le}
                        exit;
                     end;
                  S1[vitri]:=kytu;
               end;
            2: begin
                  readln(fo,vitri1,vitri2);
                  if (vitri1<1) or (vitri2>length(s1)) or (vitri1<>vitri2-1) then
                     begin
                        error[p]:=4; {Bien doi loai 2 khong hop le}
                        exit;
                     end;
                  c:=S1[vitri1];
                  S1[vitri1]:=s1[vitri2];
                  s1[vitri2]:=c;
               end;
            3: begin
                  read(fo,vitri);
                  repeat read(fo,kytu) until kytu<>#32;
                  readln(fo);
                  if (vitri<0) or (vitri>length(s1)) then
                     begin
                        error[p]:=5; {Bien doi loai 3 khong hop le}
                        exit;
                     end;
                  insert(kytu,s1,vitri+1);
               end;
            4: begin
                  readln(fo,vitri);
                  if (vitri<1) or (vitri>length(s1)) then
                     begin
                        error[p]:=6; {Bien doi loai 4 khong hop le}
                        exit;
                     end;
                  delete(s1,vitri,1);
               end;
         end;
      end;
   if s1<>s2 then
      begin
         error[p]:=7; {Bien doi khong thanh S2}
         exit;
      end;
   diem[p]:=0.5;
   if kqo>kqm[p] then
      begin
         error[p]:=8; {Ket qua khong toi uu}
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
      3: writeln('Bien doi loai 1 khong hop le');
      4: writeln('Bien doi loai 2 khong hop le');
      5: writeln('Bien doi loai 3 khong hop le');
      6: writeln('Bien doi loai 4 khong hop le');
      7: writeln('Bien doi khong thanh S2');
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