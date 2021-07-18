{$A+,B-,D+,E+,F-,G-,I-,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt,dos;

const
    dtfi='FALL.IN';
    dtfo='FALL.OU';
    dtfm='';
    kqm: array[0..9] of longint=(6159,8369,5574,8260,4026,6563,9716,9051,5416,878);
    maxN=1001;

type
   van=record x1, x2, H, id: longint end;

var
   Error: array[0..9] of integer;
   Diem: array[0..9] of real;
   p: integer;
   tfi,tfo,tfm: string[12];
   d: SearchRec;
   fi,fo,fm: text;

   N: longint;
   xx,yy,delta: longint;
   a: array[1..maxN] of van;


procedure Docdl;
var i: longint;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,N,xx,yy,delta);
   for i:=1 to N do
      with a[i] do
         begin
            id:=i;
            readln(fi,x1,x2,H);
         end;
   close(fi);
end;

function CatNgang(u,v: longint): boolean;
begin
   CatNgang:=(a[u].H<yy) and (a[u].H>a[v].H) and
             (a[u].x1<=xx) and (xx<=a[u].x2);
end;

procedure Cham;
var T,kqo,i,k,j: longint;
begin
   readln(fo,kqo);
   if kqo>kqm[p] then
      begin
         error[p]:=3; {Phuong an khong toi uu}
         exit;
      end;
   T:=0;
   while not seekeof(fo) do
      begin
         readln(fo,i,k);
         k:=k+1;
         if a[i].H>yy then
            begin
               error[p]:=4; {Roi len tren ???}
               exit;
            end;
         if (xx<a[i].x1) or (xx>a[i].x2) then
            begin
               error[p]:=5; {Roi ra ngoai}
               exit;
            end;
         if yy-a[i].H>delta then
            begin
               error[p]:=6; {Roi qua do cao cho phep}
               exit;
            end;
         for j:=1 to N do
            if CatNgang(j,i) then
               begin
                  error[p]:=7; {Co Van cat ngang}
                  exit;
               end;
         if k=1 then T:=T+(xx-a[i].x1)+(yy-a[i].H)
                else T:=T+(a[i].x2-xx)+(yy-a[i].H);
         if k=1 then xx:=a[i].x1 else xx:=a[i].x2;
         yy:=a[i].H;
      end;
   for i:=1 to N do
      if (a[i].H<yy) and (a[i].x1<=xx) and (a[i].x2>=xx) then
         begin
            error[p]:=7;
            exit;
         end;
   if yy>delta then
      begin
         error[p]:=6;
         exit;
      end;
   T:=T+yy;
   if T<>kqo then
      begin
         error[p]:=8; {Tinh Thoi gian sai}
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
      3: writeln('Phuong an khong toi uu');
      4: writeln('Roi len tren ???');
      5: writeln('Roi ra ngoai');
      6: writeln('Roi qua do cao cho phep');
      7: writeln('Co Van cat ngang');
      8: writeln('Tinh Thoi gian sai');
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