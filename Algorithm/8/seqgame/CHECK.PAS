{$M $4000,0,0}

Uses crt,Dos;

const
    f_input          =     'Seqgame.inp';
    f_output         =     'Seqgame.out';
    dtfi             =     'IN.';
    dtfo             =     'OUT.';
    dtfm             =     'ANS.';
    Pmin             =     1;
    Pmax             =     11;

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

procedure Docdl;
begin
end;

procedure Cham;
var kqm,kqo: extended;
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
   readln(fm,kqm);
   readln(fo,kqo);
   if ioresult<>0 then
      begin
         error[p]:=2;
         exit;
      end;
   if abs(kqm-kqo)>0.1 then
      begin
         error[p]:=4; {Sai dap so}
         exit;
      end;
   if p<=10 then diem[p]:=9 else diem[p]:=10;
end;

procedure InError(p: LongInt);
begin
   textcolor(red);
   case Error[p] of
      0: writeln;
      1: writeln('Khong co file OUTPUT');
      2: writeln('Loi doc file OUTPUT');
      3: writeln('Time=',(Tend[p]-Tbegin[p])/18.2:0:3,' s');
      4: writeln('Sai dap so');
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
