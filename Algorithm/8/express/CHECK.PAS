{$M $4000,0,0}

Uses crt,Dos;

const
    f_input          =     'Express.inp';
    f_output         =     'Express.out';
    dtfi             =     'IN.';
    dtfo             =     'OUT.';
    dtfm             =     'ANS.';
    Pmin             =     1;
    Pmax             =     10;

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

   N,M: integer;
   s: array[1..401] of char;
   so: array[1..401] of char;

procedure Docdl;
begin
   assign(fi,tfi); reset(fi);
   n:=0;
   while not seekeoln(fi) do
      begin
         inc(n);
         read(fi,s[n]);
      end;
   close(fi);
end;

function ok: boolean;
var d1,d2,d3,i: integer;
begin
   ok:=false;
   d1:=0;
   d2:=0;
   d3:=0;
   for i:=1 to M do
      begin
         case so[i] of
           '(': inc(d1);
           ')': dec(d1);
           '[': inc(d2);
           ']': dec(d2);
           '{': inc(d3);
           '}': dec(d3);
         end;
         if d1<0 then exit;
         if d2<0 then exit;
         if d3<0 then exit;
      end;
   if (d1<>0) or (d2<>0) or (d3<>0) then exit;
   ok:=true;
end;

function sub: boolean;
var i,j: integer;
begin
   sub:=false;
   j:=0;
   for i:=1 to N do
      begin
         repeat inc(j) until (j>M) or (so[j]=s[i]);
         if j>m then exit;
      end;
   sub:=true;
end;

procedure Cham;
var kqm,kqo: longint;
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
   if kqo>kqm then
      begin
         error[p]:=4; {khong toi uu}
         exit;
      end;
   M:=0;
   while not seekeoln(fo) do
      begin
         inc(m);
         read(fo,so[m]);
      end;
   if M-N<>kqo then
      begin
         error[p]:=5; {Tinh so luong sai}
         exit;
      end;
   if not ok then
      begin
         error[p]:=6; {Khong phai la BTD}
         exit;
      end;
   if not sub then
      begin
         error[p]:=7; {Them khong dung}
         exit;
      end;
   diem[p]:=10;
end;

procedure InError(p: LongInt);
begin
   textcolor(red);
   case Error[p] of
      0: writeln;
      1: writeln('Khong co file OUTPUT');
      2: writeln('Loi doc file OUTPUT');
      3: writeln('Time=',(Tend[p]-Tbegin[p])/18.2:0:3,' s');
      4: writeln('khong toi uu');
      5: writeln('Tinh so luong sai');
      6: writeln('Khong phai la BTD');
      7: writeln('Them khong dung');
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
