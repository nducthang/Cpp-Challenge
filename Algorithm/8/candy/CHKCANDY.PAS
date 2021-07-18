{$A+,B-,D+,E+,F-,G-,I-,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt,dos;

const
    dtfi='CANDY.IN';
    dtfo='CANDY.OU';
    dtfm='CANDY.AS';

var
   Error: array[0..9] of integer;
   Diem: array[0..9] of real;
   p: integer;
   tfi,tfo,tfm: string[12];
   d: SearchRec;
   fi,fo,fm: text;
   N: longint;
   a: array[1..1000] of longint;
   Sout,Smau: array[1..2] of longint;
   Dout,Dmau: longint;
   x: array[1..1000] of longint;

procedure Docdl;
begin
  assign(fi,tfi); reset(fi);
  N:=0;
  while not seekeof(fi) do
     begin
        inc(n);
        read(fi,a[n]);
     end;
  close(fi);
  assign(fm,tfm); reset(fm);
  readln(fm,Smau[1],Smau[2],Dmau);
  close(fm);
end;

procedure Cham;
var u,i: longint;
    T: array[1..2] of longint;
begin
   {Kiem tra doc file output}
   readln(fo,Sout[1],Sout[2],Dout);
   if ioresult<>0 then
      begin
         error[p]:=2;
         exit;
      end;
   fillchar(x,sizeof(x),0);
   while not seekeoln(fo) do
      begin
         read(fo,u);
         if ioresult<>0 then
            begin
               error[p]:=2;
               exit;
            end;
         if (u<1) or (u>n) or (x[u]<>0) then
            begin
               error[p]:=3; {khong dung qui cach}
               exit;
            end;
         x[u]:=1;
      end;
   readln(fo);
   while not seekeoln(fo) do
      begin
         read(fo,u);
         if ioresult<>0 then
            begin
               error[p]:=2;
               exit;
            end;
         if (u<1) or (u>n) or (x[u]<>0) then
            begin
               error[p]:=3; {khong dung qui cach}
               exit;
            end;
         x[u]:=2;
      end;
   {Phan tich}
   T[1]:=0;
   T[2]:=0;
   for i:=1 to N do
      Begin
         if x[i]=0 then
            begin
               error[p]:=4; {con goi chua chia}
               exit;
            end;
         T[x[i]]:=T[x[i]]+a[i];
      end;
   if (T[1]<>Sout[1]) or (T[2]<>Sout[2]) or (Dout<>abs(T[1]-T[2])) then
      begin
         error[p]:=5; {TinhTong hoac chenh lech sai}
         exit;
      end;
   if Dmau>=abs(T[1]-T[2]) then Diem[p]:=1.0
                           else Diem[p]:=int(Dmau/abs(T[1]-T[2])*10)/10;
end;

procedure InError(p: LongInt);
begin
   textcolor(red);
   case Error[p] of
      0: writeln;
      1: writeln('Khong co file OUTPUT');
      2: writeln('Loi doc file OUTPUT');
      3: writeln('Khong dung qui cach');
      4: writeln('Con goi keo chua chia');
      5: writeln('Tinh tong hoac chenh lech sai');
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
   writeln('         *          Ket qua cham bai CHIA KEO                   *');
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