{$A+,B-,D+,E+,F-,G-,I-,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt,dos;

const
    dtfi='CHONSO.IN';
    dtfo='CHONSO.OU';
    dtfm='';
    kqm: array[0..9] of longint=(11302558,
                                 204,
                                 10,
                                 983024,
                                 2230938,
                                 3408282,
                                 4858591,
                                 5836064,
                                 8919293,
                                 10014036);

var
   Error: array[0..9] of integer;
   Diem: array[0..9] of real;
   p: integer;
   tfi,tfo,tfm: string[12];
   d: SearchRec;
   fi,fo,fm: text;

   N: integer;
   a: array[1..1000] of longint;

   dd: array[1..1000] of byte;

procedure Docdl;
var i: integer;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,N);
   for i:=1 to N do readln(fi,a[i]);
end;

procedure Cham;
var T,kqo: longint;
    v,M,i,u: integer;
begin
   readln(fo,kqo,M);
   if ioresult<>0 then
      begin
         error[p]:=2;
         exit;
      end;
   if (M<1) or (M>N) then
      begin
         error[p]:=6; {So luong chon khong dung}
         exit;
      end;
   T:=0;
   fillchar(dd,sizeof(dd),0);
   v:=0;
   for i:=1 to M do
      begin
         readln(fo,u);
         if ioresult<>0 then
            begin
               error[p]:=2;
               exit;
            end;
         if (u<=v) or (u>N) then
            begin
               error[p]:=3; {Chi so khong hop le}
               exit;
            end;
         dd[u]:=1;
         if (u>=3) and (dd[u]+dd[u-1]+dd[u-2]=3) then
            begin
               error[p]:=4; {Co 3 so hang lien tiep duoc chon}
               exit;
            end;
         if u-v>3 then
            begin
               error[p]:=5; {Co 3 so hang lien tiep khong duoc chon}
               exit;
            end;
         T:=T+a[u];
         v:=u;
      end;
   if T<>kqo then
      begin
         error[p]:=7; {Tinh tong khong dung}
         exit;
      end;
   if kqo<kqm[p] then
      begin
         error[p]:=8; {Khong toi uu}
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
      3: writeln('Chi so khong hop le');
      4: writeln('Co 3 so hang lien tiep duoc chon');
      5: writeln('Co 3 so hang lien tiep khong duoc chon');
      6: writeln('So luong chon khong dung');
      7: writeln('Tinh tong khong dung');
      8: writeln('Khong toi uu');
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
         Docdl;
         assign(fo,tfo); reset(fo);
         Cham;
         close(fo);
      end;
   Inkq;
   XoaFile;
END.