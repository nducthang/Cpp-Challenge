{$A+,B-,D+,E+,F-,G-,I-,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt,dos;

const
    dtfi='BANK.IN';
    dtfo='BANK.OU';
    dtfm='BANK.AN';

var
   Error: array[0..9] of integer;
   Diem: array[0..9] of real;
   p: integer;
   tfi,tfo,tfm: string[12];
   d: SearchRec;
   fi,fo,fm: text;

   N: integer;
   a: array[1..3,1..100] of byte;
   Sout,Smau: String;
   ok: boolean;
   dd: array[1..3,1..100] of byte;

procedure Docdl;
var i,j: integer;
    c: char;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,n);
   for i:=1 to 3 do
      begin
         for j:=1 to n do
            begin
               read(fi,c);
               a[i,j]:=ord(c)-48;
            end;
         readln(fi);
      end;
   close(fi);
   assign(fm,tfm); reset(fm);
   readln(fm,Smau);
   close(fm);
end;

procedure GapDoi;
var m,nho,tich,i: integer;
begin
   m:=length(Sout);
   nho:=0;
   for i:=m downto 1 do
      begin
         tich:=(ord(Sout[i])-48)*2+nho;
         Sout[i]:=chr(tich mod 10+48);
         nho:=tich div 10;
      end;
   if nho>0 then Sout:=chr(nho+48)+Sout;
end;

procedure CongMot;
begin
   Sout[length(Sout)]:=succ(Sout[length(Sout)]);
end;

function NhoHon: boolean;
var nm,no,i: integer;
begin
   nm:=length(smau);
   no:=length(sout);
   if nm<no then for i:=nm+1 to no do Smau:='0'+Smau
            else for i:=no+1 to nm do Sout:='0'+Sout;
   NhoHon:=(Sout<Smau);
end;

procedure cham;
var u,v: integer;
    c: char;
begin
   ok:=false;
   Sout:=chr(a[1,1]+48);
   u:=1; v:=1;
   fillchar(dd,sizeof(dd),0);
   dd[1,1]:=1;
   while not seekeoln(fo) do
      begin
         read(fo,c);
         if ioresult<>0 then
            begin
               error[p]:=2;
               exit;
            end;
         case c of
            'R': inc(v);
            'L': dec(v);
            'U': dec(u);
            'D': inc(u);
         end;
         if (u<0) or (u>3) or (v<0) or (v>n) then exit;
         if dd[u,v]=1 then exit;
         GapDoi;
         if a[u,v]=1 then CongMot;
         dd[u,v]:=1;
      end;
   if NhoHon then
      begin
         error[p]:=3; {Khong toi uu}
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
      3: writeln('Khong toi uu');
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