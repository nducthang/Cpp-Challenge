{$A+,B-,D+,E+,F-,G-,I-,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt,dos;

const
    dtfi='WIRES.IN';
    dtfo='WIRES.OU';
    dtfm='WIRES.AN';

var
   Error: array[0..9] of integer;
   Diem: array[0..9] of real;
   p: integer;
   tfi,tfo,tfm: string[12];
   d: SearchRec;
   fi,fo,fm: text;

   N: integer;
   a: array[1..1000] of integer;
   slmau,slout: integer;
   ok: boolean;
   x: array[1..1000] of integer;

procedure Docdl;
var i,u: integer;
begin
   fillchar(a,sizeof(a),0);
   assign(fi,tfi); reset(fi);
   readln(fi,N);
   for i:=1 to N do
      begin
         read(fi,u);
         a[u]:=i;
      end;
   close(fi);
   assign(fm,tfm); reset(fm);
   readln(fm,slmau);
   close(fm);
end;

procedure Cham;
var d: integer;
begin
   ok:=false;
   readln(fo,slout);
   if ioresult<>0 then exit;
   if slout<slmau then exit;
   d:=1;
   read(fo,x[1]);
   if ioresult<>0 then exit;
   while not seekeoln(fo) do
      begin
         inc(d);
         read(fo,x[d]);
         if ioresult<>0 then exit;
         if a[x[d]]<=a[x[d-1]] then exit;
      end;
   ok:=(d=slout);
   if ok then diem[p]:=1.0;
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
         Docdl;
         assign(fo,tfo); reset(fo);
         Cham;
         close(fo);
      end;
   Inkq;
   XoaFile;
END.