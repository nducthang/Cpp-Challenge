{$A+,B-,D+,E+,F-,G-,I-,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}


uses Crt,Dos;

var
   diem: array[0..9] of real;
   Error: array[0..9] of integer;
   p: integer;
   tfm,tfo: string[12];
   d: SearchRec;
   fm,fo: text;
   Smau,Sout: integer;

procedure Cham;
var dem,dung: real;
    i: integer;
begin
   readln(fm,Smau);
   readln(fo,Sout);
   if IOresult<>0 then
      begin
         Error[p]:=2;
         exit;
      end;
   if Smau<>Sout then
      begin
         Error[p]:=3;
         exit;
      end;
   Diem[p]:=1.0;
end;

procedure InError(p: integer);
begin
   textcolor(Red);
   Case error[p] of
      0: writeln;
      1: writeln('.Khong co file OUTPUT');
      2: writeln('.Loi doc file OUTPUT');
      3: writeln('.Ket qua khong dung');
   end;
   Textcolor(White);
end;

procedure Inkq;
var Tong: real;
begin
   Textcolor(White);
   clrscr;
   writeln;
   writeln;
   writeln;
   Writeln('          ************************************************');
   Writeln('          *           Cham bai: PALINDROME               *');
   Writeln('          ************************************************');
   Tong:=0.0;
   for p:=0 to 9 do
      begin
         Tong:=Tong+Diem[p];
         write('              TEST :',p,'=',Diem[p]:5:1,' Diem');
         InError(p);
      end;
   Writeln('          ------------------------------------------------');
   textcolor(Green);
   Writeln('            Tong diem=',Tong:5:1,' Diem');
   textcolor(white);
end;

procedure XoaFile;
begin
   for p:=0 to 9 do
      begin
         tfo:='PALIN.OU'+chr(p+48);
         FindFirst(tfo,Archive,D);
         if DosError<>0 then continue;
         assign(fo,tfo);
         erase(fo);
      end;
end;


BEGIN
   Fillchar(Diem,sizeof(Diem),0);
   Fillchar(Error,sizeof(Error),0);
   for p:=0 to 9 do
      begin
         tfo:='PALIN.OU'+chr(p+48);
         tfm:='PALIN.AS'+chr(p+48);
         FindFirst(tfo,Archive,d);
         if DosError<>0 then
            begin
               Error[p]:=1; {Khong co uoutput}
               continue;
            end;
         assign(fm,tfm); reset(fm);
         assign(fo,tfo); reset(fo);
         Cham;
         close(fm); close(fo);
      end;
   Inkq;
   XoaFile;
END.