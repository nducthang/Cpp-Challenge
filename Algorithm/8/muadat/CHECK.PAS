{$M $4000,0,0}

Uses crt,Dos;

const
    f_input          =     'Muadat.inp';
    f_output         =     'Muadat.out';
    dtfi             =     'IN.';
    dtfo             =     'OUT.';
    dtfm             =     'ANS.';
    Pmin             =     1;
    Pmax             =     20;

var
   Error: array[Pmin..Pmax] of integer;
   Diem: array[Pmin..Pmax]  of integer;
   p: integer;
   tfi,tfo,tfm: string[12];
   d: SearchRec;
   fi,fo,fm: text;
   Tbegin, Tend: array[Pmin..Pmax] of longint;
   TimeLimit: longint;
   Time: longint absolute 0:$046c;

   N: longint;
   kqm,kqo: longint;

procedure Docdl;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,N);
   close(fi);
end;

procedure Cham;
var T,u,v: longint;
begin
   if Tend[p]-Tbegin[p]>Timelimit then
      begin
         error[p]:=3;
         exit;
      end;
   if seekeof(fo) then
      begin
         error[p]:=2;
         exit;
      end;
   kqm:=0;
   while not seekeoln(fm) do
      begin
         inc(kqm);
         read(fm,u);
      end;
   kqo:=1;
   read(fo,u);
   T:=u*u;
   while not seekeoln(fo) do
      begin
         inc(kqo);
         v:=u;
         read(fo,u);
         if (u<1) then
            begin
               error[p]:=5; {Hinh vuong khong hop le}
               exit;
            end;
         if u>v then
            begin
               error[p]:=4; {khong giam dan}
               exit;
            end;
         T:=T+u*u;
      end;
   if T<>N then
      begin
         error[p]:=6; {Thua hoac thieu tien}
         exit;
      end;
   if kqm>=kqo then diem[p]:=5 else
      diem[p]:=trunc(sqr(kqo/kqm)*5);
end;

procedure InError(p: LongInt);
begin
   textcolor(red);
   case Error[p] of
      0: writeln;
      1: writeln('Khong co file OUTPUT');
      2: writeln('Loi doc file OUTPUT');
      3: writeln('Time=',(Tend[p]-Tbegin[p])/18.2:0:3,' s');
      4: writeln('khong giam dan');
      5: writeln('Hinh vuong khong hop le');
      6: writeln('Thua hoac thieu tien');
   end;
   textcolor(white);
end;

procedure Inkq;
var T: Integer;
begin
   clrscr;
   textcolor(white);
   writeln('KET QUA CHAM BAI  : ');
   T:=0;
   for p:=Pmin to Pmax do
      begin
         write('TEST ',p:4,': ',Diem[p]:4,' Diem.');
         InError(p);
         T:=T+diem[p];
      end;
   writeln('--------------------------------------------------------');
   textcolor(green);
   writeln('Tong cong = ',T:4,' Diem');
   textcolor(white);
   readln;
end;

procedure XoaFile;
var cp: string[2];
begin
   for p:=Pmin to Pmax do
      begin
         str(p,cp);
         if p<10 then cp:='0'+cp;
         tfo:=dtfo+cp;
         FindFirst(tfo,archive,d);
         if DosError<>0 then continue;
         assign(fo,tfo);
         erase(fo);
      end;
end;

procedure CopyFile(f1,f2: string);
var
  FromF, ToF: file;
  NumRead, NumWritten: Word;
  Buf: array[1..2048] of Char;
begin
  {$i-}
  Assign(FromF, f1); { Open input file }
  Reset(FromF, 1);  { Record size = 1 }
  if ioresult<>0 then exit;
  Assign(ToF, f2); { Open output file }
  Rewrite(ToF, 1);  { Record size = 1 }
  repeat
    BlockRead(FromF, Buf, SizeOf(Buf), NumRead);
    BlockWrite(ToF, Buf, NumRead, NumWritten);
  until (NumRead = 0) or (NumWritten <> NumRead);
  Close(FromF);
  Close(ToF);
end;

procedure Delfile(tf: string);
var f: file;
begin
   FindFirst(tf,archive,d);
   if DosError<>0 then exit;
   assign(f,tf);
   erase(f);
end;


procedure Run;
var programname: string;
    p1,p2: integer;
    cp: string[2];
begin
   clrscr;
   write('Nhap ten file chuong trinh:'); readln(Programname);
   write('Nhap thoi gian cham (s)   :'); readln(TimeLimit);
   write('Tu    TEST                :'); readln(p1);
   write('Den   TEST                :'); readln(p2);
   TimeLimit:=TimeLimit*19;
   programname:=programname+'.EXE';
   for p:=p1 to p2 do
      begin
         writeln('Run Test:',p);
         str(p,cp);
         if p<10 then cp:='0'+cp;
         tfi:=dtfi+cp;
         tfo:=dtfo+cp;
         CopyFile(tfi,f_input);
         SwapVectors;
         TBegin[p]:= Time;
         Exec(Programname,'');
         TEnd[p]:= Time;
         SwapVectors;
         CopyFile(f_output,tfo);
         DelFile(f_output);
      end;
   DelFile(f_input);
end;

var cp: string[2];


BEGIN
   Run;
   fillchar(Error,sizeof(Error),0);
   fillchar(Diem,sizeof(Diem),0);
   for p:=Pmin to Pmax do
      begin
         str(p,cp);
         if p<10 then cp:='0'+cp;
         tfi:=dtfi+cp;
         tfm:=dtfm+cp;
         tfo:=dtfo+cp;
         FindFirst(tfo,Archive,d);
         if DosError<>0 then
            begin
               Error[p]:=1;
               continue;
            end;
         Docdl;
         assign(fo,tfo); reset(fo);
         assign(fm,tfm); reset(fm);
         Cham;
         close(fo); close(fm);
      end;
   Inkq;
   XoaFile;
END.
