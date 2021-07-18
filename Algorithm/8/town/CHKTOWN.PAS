{$A+,B-,D+,E+,F-,G-,I-,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt,dos;

const
    dtfi='TOWN.IN';
    dtfo='TOWN.OU';
    dtfm='TOWN.AN';

var
   Error: array[0..9] of integer;
   Diem: array[0..9] of real;
   p: integer;
   tfi,tfo,tfm: string[12];
   d: SearchRec;
   fi,fo,fm: text;

   N: integer;
   a: array[1..5000,1..3] of byte;
   Hmau,Hout: LongInt;
   ok: boolean;


procedure Docdl;
var i,k,l: integer;
    tg: byte;
begin
   assign(fi,tfi); reset(fi);
   read(fi,N);
   for i:=1 to n do
      begin
         read(fi,a[i,1],a[i,2],a[i,3]);
         for k:=1 to 2 do
           for l:=k+1 to 3 do
              if a[i,k]<a[i,l] then
                 begin
                    tg:=a[i,k];
                    a[i,k]:=a[i,l];
                    a[i,l]:=tg;
                 end;
      end;
   close(fi);
   assign(fm,tfm); reset(fm);
   readln(fm,Hmau);
   close(fm);
end;

procedure Cham;
var M: integer;
    dd: array[1..5000] of byte;
    v1,v2,v3,u1,u2,u3: integer;
    i,k: integer;
begin
   ok:=false;
   readln(fo,M);
   if ioresult<>0 then exit;
   Hout:=0;
   fillchar(dd,sizeof(dd),0);
   v1:=255; v2:=255; v3:=255;
   for i:=1 to M do
      begin
         readln(fo,k,u1,u2,u3);
         if ioresult<>0 then exit;
         if (k<0) or (k>N) then exit;
         if dd[k]=1 then exit;
         if (a[k,2]<>u1) or (a[k,1]<>u2) or (a[k,3]<>u3) then exit;
         if (u1>v1) or (u2>v2) then exit;
         Hout:=Hout+a[k,3];
         v1:=u1; v2:=u2; v3:=u3;
         dd[k]:=1;
      end;
   if Hout<Hmau then exit;
   ok:=true;
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
         Docdl;
         assign(fo,tfo); reset(fo);
         Cham;
         close(fo);
      end;
   Inkq;
   XoaFile;
END.