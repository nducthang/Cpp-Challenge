{$i-}
{$M $4000,0,0}
uses crt,dos;

const
    f_input          =     'SUB.INP';
    f_output         =     'SUB.OUT';
    dtfi             =     'SUB.IN';
    dtfo             =     'SUB.OU';
    dtfm             =     'SUB.AN';

var
   Error: array[0..9] of integer;
   Diem: array[0..9] of real;
   p: integer;
   tfi,tfo,tfm: string[12];
   d: SearchRec;
   fi,fo,fm: text;
   Tbegin, Tend: array[0..9] of longint;
   time: longint absolute 0:$046c;
   TimeLimit: longint;

   N: integer;
   a: array[1..100] of integer;
   T: integer;

procedure Docdl;
var i: integer;
begin
   assign(fi,tfi); reset(fi);
   read(fi,N,T);
   for i:=1 to N do read(fi,a[i]);
   close(fi);
end;

procedure Cham;
var u,v: integer;
begin
   if Tend[p]-Tbegin[p]>TimeLimit then
      begin
         error[p]:=3;
         exit;
      end;

   while not seekeof(fo) do
      begin
         readln(fo,u);
         if ioresult<>0 then
            begin
               error[p]:=2;
               exit;
            end;
         if (u<=0) or (u>=N) then
            begin
               error[p]:=4; {Phep BD khong hop le}
               exit;
            end;
         a[u]:=a[u]-a[u+1];
         for v:=u+1 to N-1 do a[v]:=a[v+1];
         dec(N);
      end;

   if a[1]<>T then
      begin
         error[p]:=5; {Khong bang T}
         exit;
      end;

   diem[p]:=1;

end;

procedure InError(p: LongInt);
begin
   textcolor(red);
   case Error[p] of
      0: writeln;
      1: writeln('Khong co file OUTPUT');
      2: writeln('Loi doc file OUTPUT');
      3: writeln('Time=',(Tend[p]-Tbegin[p])/19:0:3,' s');
      4: writeln('Phep BD khong hop le');
      5: writeln('Khong bang T');
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
   readln;
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
begin
   clrscr;
   write('Nhap ten file chuong trinh:'); readln(Programname);
   write('Nhap thoi gian cham       :'); readln(TimeLimit);
   write('Tu    TEST                :'); readln(p1);
   write('Den   TEST                :'); readln(p2);
   TimeLimit:=TimeLimit*19;
   programname:=programname+'.EXE';
   for p:=p1 to p2 do
      begin
         writeln('Run Test:',p);
         tfi:=dtfi+chr(p+48);
         tfo:=dtfo+chr(p+48);
         CopyFile(tfi,f_input);
         SwapVectors;
         Tbegin[p]:=Time;
         Exec(Programname,'');
         Tend[p]:=Time;
         SwapVectors;
         CopyFile(f_output,tfo);
         DelFile(f_output);
      end;
   DelFile(f_input);
end;


BEGIN
   Run;
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