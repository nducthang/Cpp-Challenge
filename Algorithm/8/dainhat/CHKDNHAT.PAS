{$A+,B-,D+,E+,F-,G-,I-,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt,Dos;

var
   Error: array[0..9] of integer;
   Diem: array[0..9] of real;
   p: integer;
   tfm,tfo: string[12];
   d: SearchRec;
   fm,fo: text;
   Lmau,Lout: LongInt;

procedure InError(p: integer);
begin
   textcolor(Red);
   case Error[p] of
      0: writeln;
      1: writeln('Khong co file OUTPUT');
      2: writeln('Loi dang file OUTPUT');
      3: writeln('Ket qua Dung la:',Lmau);
   end;
   textcolor(white);
end;

procedure Inkq;
var Tong: real;
begin
   writeln;
   writeln;
   writeln;
   textcolor(white);
   writeln('           ******************************************************');
   writeln('           *     Ket qua cham bai DOAN DAU DAI NHAT             *');
   writeln('           ******************************************************');
   Tong:=0;
   for p:=0 to 9 do
      begin
         write('              TEST ',p,':', diem[p]:4:1,' Diem.');
         InError(p);
         Tong:=Tong+Diem[p];
      end;
   writeln('           ------------------------------------------------------');
   textcolor(Green);
   writeln('           Tong cong:',Tong:4:1,' Diem.');
   textcolor(white);
end;

procedure XoaFile;
begin
   for p:=0 to 9 do
      begin
         tfo:='OUTPUT.TX'+chr(p+48);
         FindFirst(tfo,archive,d);
         if DosError<>0 then continue;
         assign(fo,tfo);
         erase(fo);
      end;
end;

BEGIN
   Fillchar(Error,sizeof(Error),0);
   Fillchar(Diem,sizeof(Diem),0);
   clrscr;
   for p:=0 to 9 do
      begin
         tfm:='OUTPUT.AS'+chr(p+48);
         tfo:='OUTPUT.TX'+chr(p+48);
         FindFirst(tfo,Archive,d);
         if DosError<>0 then
            begin
               Error[p]:=1;
               continue;
            end;
         assign(fm,tfm); reset(fm);
         readln(fm,Lmau);
         close(fm);
         assign(fo,tfo); reset(fo);
         if IOResult<>0 then
            begin
               Error[p]:=2;
               continue;
            end;
         readln(fo,Lout);
         if IOResult<>0 then
            begin
               Error[p]:=2;
               close(fo);
               continue;
            end;
         close(fo);
         if Lout=Lmau then Diem[p]:=1.0 else
            begin
               Error[p]:=3;
               Diem[p]:=0.0;
            end;
      end;
   inkq;
   XoaFile;
END.
