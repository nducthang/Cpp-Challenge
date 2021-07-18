{$A+,B-,D+,E+,F-,G-,I-,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt,dos;

const
    dtfi='TICK.IN';
    dtfo='TICK.OU';
    dtfm='TICK.AS';
    maxN=2000;
    Zmau: array[0..9] of LongInt=(12264188,1198139,2449932,3551603,5084206,
                                 6064952,7426984,8681777,9939375,10783990);

var
   Error: array[0..9] of integer;
   Diem: array[0..9] of real;
   p: integer;
   tfi,tfo,tfm: string[12];
   d: SearchRec;
   fi,fo,fm: text;

   N: integer;
   t,r: array[1..maxN] of integer;
   Zout: LongInt;
   x: array[1..maxN] of byte;
   good: boolean;

procedure Docdl;
var i: integer;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,N);
   for i:=1 to N do read(fi,t[i]); readln(fi);
   for i:=1 to N-1 do read(fi,r[i]);
   close(fi);
end;

procedure Cham;
var i,k: integer;
    S: LongInt;
begin
   readln(fo,Zout);
   if ioresult<>0 then exit;
   for i:=1 to N do x[i]:=1;
   read(fo,k);
   if ioresult<>0 then exit;
   if k>0 then
      begin
         x[k]:=2;
         while not seekeoln(fo) do
            begin
               read(fo,k);
               if ioresult<>0 then exit;
               x[k]:=2;
            end;
      end;

   good:=false;
   if Zout>Zmau[p] then exit;
   if x[1]=2 then exit;
   if x[2]=1 then S:=t[1] else S:=r[1];
   for i:=2 to N-1 do
      begin
         if (x[i]=2) and (x[i-1]=2) then exit;
         if (x[i]=1) and (x[i+1]=2) then S:=S+r[i] else
         if (x[i]=1) and (x[i+1]=1) then S:=S+t[i];
      end;
   if (x[n]=2) and (x[n-1]=2) then exit;
   if (x[n]=1) then S:=S+t[n];
   if S<>Zout then exit;
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
         Docdl;
         assign(fo,tfo); reset(fo);
         Cham;
         close(fo);
      end;
   Inkq;
   XoaFile;
END.

