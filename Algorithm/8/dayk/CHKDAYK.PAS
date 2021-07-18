{$A+,B-,D+,E+,F-,G-,I-,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt,dos;

const
    dtfi='DAYK.IN';
    dtfo='DAYK.OU';
    dtfm='';
    kqm:array[0..9] of integer=(811,63,112,266,279,364,450,451,623,717);

var
   Error: array[0..9] of integer;
   Diem: array[0..9] of real;
   p: integer;
   tfi,tfo,tfm: string[12];
   d: SearchRec;
   fi,fo,fm: text;

   N,K: integer;
   a: array[1..1000] of integer;
   count: integer;
   dd: array[1..1000] of integer;
   ok: boolean;
   Gdm, Gdo: integer;
   Gd: array[1..11] of integer;

procedure Docdl;
var i: integer;
begin
   assign(fi,tfi); reset(fi);
   read(fi,N,K);
   for i:=1 to N do read(fi,a[i]);
   close(fi);
end;

procedure Check; {thu tuc kiem tra k gian doan}
var v, iv, i: integer;
begin
   ok:=false;
   v:=-maxint;
   iv:=0;
   Gdm:=0; {so luong diem gian doan}
   for i:=1 to N do
      if (dd[i]=0) then
         begin
            if a[i]<=v then
               begin
                  inc(Gdm);
                  Gd[Gdm]:=iv;
                  if Gdm>k then exit;
               end;
            v:=a[i];
            iv:=i;
         end;
   ok:=true;
end;

procedure Cham;
var u,v,i: integer;
begin
   readln(fo,Count); {doc so luong so bi xoa}
   if count>kqm[p] then
      begin
         error[p]:=3; {Ket qua khong toi uu}
         exit;
      end;
   fillchar(dd,sizeof(dd),0);
   v:=0;
   for i:=1 to count do
      begin
         readln(fo,u);
         if u<=v then
            begin
               error[p]:=4; {Cac vi tri xoa khong in tang dan}
               exit;
            end;
         dd[u]:=1;
         v:=u;
      end;
   Check;
   if not ok then
      begin
         error[p]:=5; {Vi pham tinh k gian doan}
         exit;
      end;
   readln(fo,Gdo);
   if Gdo<>Gdm then
      begin
         error[p]:=6; {Tinh so luong cac diem gian doan sai}
         exit;
      end;
   for i:=1 to Gdo do
      begin
         readln(fo,u);
         if u<>Gd[i] then
            begin
               error[p]:=7; {In sai cac diem gian doan}
               exit;
            end;
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
      3: writeln('Ket qua khong toi uu');
      4: writeln('Cac vi tri xoa khong in tang dan');
      5: writeln('Vi pham tinh k gian doan');
      6: writeln('Tinh so luong cac diem gian doan sai');
      7: writeln('In sai cac diem gian doan');
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