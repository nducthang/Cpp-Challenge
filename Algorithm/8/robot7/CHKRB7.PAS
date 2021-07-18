{$A+,B-,D+,E+,F-,G-,I-,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt,dos;

const
    dtfi='ROBOT.IN';
    dtfo='ROBOT.OU';
    dtfm='';
    kqm: array[0..9] of longint=(19399380,20,2,140,420,2042040,3423420,6126120,6846840,9699690);

var
   Error: array[0..9] of integer;
   Diem: array[0..9] of real;
   p: integer;
   tfi,tfo,tfm: string[12];
   d: SearchRec;
   fi,fo,fm: text;


   N: integer;
   dd: array[1..80] of byte;
   Q: array[1..80] of integer;

procedure Docdl;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,N);
   close(fi);
end;

function BSCNN(u,v: longint): longint;
var p,q,r: longint;
begin
   p:=u;
   q:=v;
   repeat
      r:=p mod q;
      if r>0 then
         begin
            p:=q;
            q:=r;
         end;
   until r=0;
   BSCNN:=(u div q)*v;
end;

procedure Cham;
var tich,kqo,i,dem,u: longint;
    tyle: real;
begin
   readln(fo,kqo);
   if ioresult<>0 then
      begin
         error[p]:=2;
         exit;
      end;
   fillchar(dd,sizeof(dd),0);
   for i:=1 to N do
      begin
         read(fo,q[i]);
         if ioresult<>0 then
            begin
               error[p]:=2;
               exit;
            end;
         if (q[i]<1) or (q[i]>N) then
            begin
               error[p]:=3; {Phep BD sai}
               exit;
            end;
         if dd[q[i]]<>0 then
            begin
               error[p]:=3;
               exit;
            end;
         dd[q[i]]:=1;
      end;
   {Tinh so phep khac nhau}
   Tich:=1;
   fillchar(dd,sizeof(dd),0);
   for i:=1 to N do
      if dd[i]=0 then
         begin
            dem:=1;
            u:=i;
            dd[i]:=1;
            repeat
               u:=q[u];
               if u<>i then
                  begin
                     inc(dem);
                     dd[u]:=1;
                  end;
            until u=i;
            Tich:=BSCNN(Tich,dem);
         end;
   if tich<>kqo then
      begin
         error[p]:=4; {Tinh sai so luong}
         exit;
      end;
   tyle:=kqo/kqm[p];
   if tyle>=1 then diem[p]:=1.0 else
      if tyle>=0.9 then diem[p]:=0.5 else
         if tyle>=0.8 then diem[p]:=0.2 else diem[p]:=0;
end;

procedure InError(p: LongInt);
begin
   textcolor(red);
   case Error[p] of
      0: writeln;
      1: writeln('Khong co file OUTPUT');
      2: writeln('Loi doc file OUTPUT');
      3: writeln('Phep BD sai');
      4: writeln('Tinh sai so luong');
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