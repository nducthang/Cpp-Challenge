{$M $4000,0,0}
uses crt,dos;

const
    f_input          =     'REDHOOD.INP';
    f_output         =     'REDHOOD.OUT';
    dtfi             =     'REDHOOD.IN';
    dtfo             =     'REDHOOD.OU';
    dtfm             =     'REDHOOD.AN';

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

procedure chuan(var s: string);
begin
   while (length(s)>0) and (s[1]=#32) do delete(s,1,1);
   while (length(s)>0) and (s[length(s)]=#32) do delete(s,length(s),1);
end;

procedure Cham;
var dem,dung: longint;
    kqm,kqo: string;
begin
   if Tend[p]-Tbegin[p]>Timelimit then
      begin
         error[p]:=3;
         exit;
      end;
   dem:=0;
   dung:=0;
   while not seekeof(fm) do
      begin
         inc(dem);
         readln(fm,kqm);
         chuan(kqm);
         readln(fo,kqo);
         if ioresult<>0 then
            begin
               error[p]:=2;
               exit;
            end;
         chuan(kqo);
         if kqm=kqo then inc(dung);
      end;
   diem[p]:=int(dung/dem*10)/10;
end;

procedure InError(p: LongInt);
begin
   textcolor(red);
   case Error[p] of
      0: writeln;
      1: writeln('Khong co file OUTPUT');
      2: writeln('Loi doc file OUTPUT');
      3: writeln('Time=',(Tend[p]-Tbegin[p])/19:0:3,' s');
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
         assign(fo,tfo); reset(fo);
         assign(fm,tfm); reset(fm);
         Cham;
         close(fo); close(fm);
      end;
   Inkq;
   XoaFile;
END.