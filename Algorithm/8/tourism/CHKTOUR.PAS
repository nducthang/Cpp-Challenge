{$A+,B-,D+,E+,F-,G-,I-,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt,dos;

const
    dtfi='TOURISM.IN';
    dtfo='TOURISM.OU';
    dtfm='TOURISM.AN';
    maxN=10000;
    kq: array[0..9] of real=(334000,7226,1813576,2719882,671699,
                            11972549,171050,485990,3097106,1760040);

type MangI=array[0..maxN] of integer;

var
   Error: array[0..9] of integer;
   Diem: array[0..9] of real;
   p: integer;
   tfi,tfo,tfm: string[12];
   d: SearchRec;
   fi,fo,fm: text;

   N: integer;
   PP: real;
   a: array[0..maxN] of real;
   x: ^mangI;
   S: real;
   slx: integer;
   good: boolean;


procedure Docdl;
var i: integer;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,N);
   readln(fi,PP);
   for i:=1 to N do read(fi,a[i]);
   a[0]:=0;
   close(fi);
end;

procedure Cham;
var i: integer;
    T: real;
begin
   readln(fo,S);
   if ioresult<>0 then exit;
   readln(fo,slx);
   if ioresult<>0 then exit;
   for i:=1 to slx do
      begin
         read(fo,x^[i]);
         if ioresult<>0 then exit;
      end;
   x^[0]:=0;

   good:=false;
   if S>kq[p] then exit;
   T:=0;
   for i:=1 to slx do
   begin
      if (x^[i]<1) or (x^[i]>N) then exit;
      T:=T+sqr(a[x^[i]]-a[x^[i-1]]-pp);
   end;
   if T<>S then exit;
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
   new(x);
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

