{$A+,B-,D+,E+,F-,G-,I-,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt,dos;

const
    dtfi='SuaTuoi.IN';
    dtfo='SuaTuoi.OU';
    dtfm='';

var
   Error: array[0..9] of integer;
   Diem: array[0..9] of real;
   p: integer;
   tfi,tfo,tfm: string[12];
   d: SearchRec;
   fi,fo,fm: text;

   N, M,L: integer;
   a: array[0..100] of integer;
   B: array[0..100] of integer;

procedure Docdl;
var i: integer;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,N,M);
   for i:=1 to N do read(fi,a[i]);
   L:=a[1];
   close(fi);
end;

procedure Cham;
var count, i, u, v: integer;
begin
   readln(fo,count);
   if (p=1) and (count=-1) then
      begin
         diem[p]:=1.0;
         exit;
      end;
   if (p=1) and (count<>-1) then
      begin
         error[p]:=3; {Do binh khong hop le}
         exit;
      end;
   if (p<>1) and (count=-1) then
      begin
         error[p]:=4; {Bao -1 la sai}
         exit;
      end;
   (* Tien hanh do *)
   for i:=0 to N do B[i]:=0;
   a[0]:=maxint div 2;
   B[1]:=a[1];
   for i:=1 to count do
      begin
         readln(fo,u,v);
         if B[u]<a[v]-b[v] then
            begin
               b[v]:=b[v]+b[u];
               b[u]:=0;
            end
         else
            begin
               b[u]:=b[u]-(a[v]-b[v]);
               b[v]:=a[v];
            end;
      end;
   if b[0]<>M then
      begin
         error[p]:=3;
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
      3: writeln('Do binh khong hop le');
      4: writeln('Bao -1 la sai');
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