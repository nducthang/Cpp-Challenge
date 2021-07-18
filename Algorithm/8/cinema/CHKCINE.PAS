{$A+,B-,D+,E+,F-,G-,I-,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt,dos;

const
    dtfi='CINEMA.IN';
    dtfo='CINEMA.OU';
    dtfm='CINEMA.AS';
    Unseen=maxlongint div 2;

var
   Error: array[0..9] of integer;
   Diem: array[0..9] of real;
   p: integer;
   tfi,tfo,tfm: string[12];
   d: SearchRec;
   fi,fo,fm: text;

   n,m,k: longint;
   a: array[1..50,1..50] of longint;
   f: array[1..50] of longint;
   pp: array[1..1000] of longint;
   Sout,Smau: longint;

procedure Docdl;
var i,j,u,v,l: longint;
begin
   assign(fi,tfi); reset(fi);
   read(fi,n,m,k);
   for i:=1 to n do
      for j:=1 to n do a[i,j]:=Unseen;
   for i:=1 to n do read(fi,f[i]);
   for i:=1 to m do
      begin
         read(fi,u,v,l);
         a[u,v]:=l;
         a[v,u]:=l;
      end;
   for i:=1 to k do read(fi,pp[i]);
   close(fi);
   for l:=1 to n do
      for i:=1 to n do
         for j:=1 to n do
            if a[i,j]>a[i,l]+a[l,j] then
               a[i,j]:=a[i,l]+a[l,j];
   for i:=1 to N do a[i,i]:=0;
   assign(fm,tfm); reset(fm);
   readln(fm,Smau);
   close(fm);
end;

procedure Cham;
var ST,u,v,i: longint;
begin
   readln(fo,sout);
   if ioresult<>0 then
      begin
         error[p]:=2;
         exit;
      end;
   ST:=0;
   v:=1;
   for i:=1 to k do
      begin
         read(fo,u);
         if ioresult<>0 then
            begin
                error[p]:=2;
                exit;
            end;
         if (u<1) or (u>n) then
            begin
               error[p]:=5;
               exit;
            end;
         if f[u]<>pp[i] then
            begin
               Error[p]:=3; {den thanh pho khong chieu phim}
               exit;
            end;
         ST:=ST+a[v,u];
         v:=u;
      end;
   if ST<>sout then
      begin
         error[p]:=4; {tinh tong khong dung}
         exit;
      end;
   if Sout<=Smau then Diem[p]:=1.0 else diem[p]:=int(Smau/Sout*10)/10;
end;

procedure InError(p: LongInt);
begin
   textcolor(red);
   case Error[p] of
      0: writeln;
      1: writeln('Khong co file OUTPUT');
      2: writeln('Loi doc file OUTPUT');
      3: writeln('Den TP khong chieu phim');
      4: writeln('Tinh tong khong dung');
      5: writeln('In khong dung qui cach');
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
