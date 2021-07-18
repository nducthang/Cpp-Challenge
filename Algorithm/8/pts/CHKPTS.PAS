{$A+,B-,D+,E+,F-,G-,I-,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt,dos;

const
    dtfi='PTS.IN';
    dtfo='PTS.OU';
    dtfm='PTS.AN';

var
   Error: array[0..9] of integer;
   Diem: array[0..9] of real;
   p: integer;
   tfi,tfo,tfm: string[12];
   d: SearchRec;
   fi,fo,fm: text;

   M,N: integer;
   a: array[1..100,1..100] of real;
   good: boolean;


procedure DocMau;
var i: integer;
begin
   N:=0;
   M:=1;
   while not seekeoln(fm) do
       begin
          inc(n);
          read(fm,a[m,n]);
       end;
   while not seekeof(fm) do
      begin
         inc(m);
         for i:=1 to N do read(fm,a[m,i]);
         readln(fm);
      end;
end;

procedure cham;
var i,j: integer;
    x: real;
begin
   good:=false;
   for i:=1 to M do
      begin
         for j:=1 to N do
            begin
               read(fo,x);
               if x<>a[i,j] then exit;
            end;
         readln(fo);
      end;
   good:=true;
   diem[p]:=1.0;
end;


procedure InError(p: LongInt);
begin
   textcolor(red);
   case Error[p] of
      0: writeln;
      1: writeln('Khong co file OUTPUT');
      2: writeln('Loi doc file OUTPUT');
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
   writeln('         *               KET QUA CHAM BAI                       *');
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
         assign(fo,tfo); reset(fo);
         assign(fm,tfm); reset(fm);
         DocMau;
         Cham;
         close(fo); close(fm);
      end;
   Inkq;
   XoaFile;
END.


{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}
uses crt;

const
   tfo='PTS.OUT';

var p,code: integer;
    tfm: string[12];
    fm,fo: text;



BEGIN
   val(paramstr(1),p,code);
   tfm:='PTS.OU'+chr(p+48);
   assign(fm,tfm); reset(fm);
   assign(fo,tfo); reset(fo);
   DocMau;
   Xet;
   if good then writeln('Ket qua DUNG') else writeln('Ket qua SAI');
   close(fo); close(fm);
END.