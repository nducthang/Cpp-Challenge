uses crt;

const
   dtfi='INP.';
   dtfo='OUT.';
   dtfm='ANS.';
   dtft='TIME.';


var
   Tg                 :    array[1..10] of longint;
   Bn                 :    array[1..10] of longint;
   Diem               :    array[1..10] of longint;
   error              :    array[1..10] of longint;

   tfi, tfo, tfm, tft :    string[12];
   fi, fo, fm, ft     :    text;
   p: longint;

procedure TimeMemory;
var s1,s: string;
    code: integer;
begin
   reset(ft);
   readln(ft,s);
   if pos('MLE',s)>0 then
      begin
         error[p]:=1; {Memory Limit Excceded}
         exit;
      end;
   if pos('TLE',s)>0 then
      begin
         error[p]:=2; {Time Limit Excceded}
         exit;
      end;
   {Lay so do thoi gian va bo nho}
   s:=copy(s,pos(':',s),255);
   while not (s[1] in ['0'..'9']) do delete(s,1,1);
   s1:=copy(s,1,pos('/',s)-1);
   val(s1,Tg[p],code);
   delete(s,1,pos(#32,s));
   while s[1]=#32 do delete(s,1,1);
   s1:=copy(s,1,pos('(',s)-1);
   val(s1,Bn[p],code);
   close(ft);
end;

procedure GanFile;
begin
   assign(fi,tfi);
   assign(fo,tfo);
   assign(fm,tfm);
   assign(ft,tft);
end;

procedure Mofile;
begin
   {$i-}
   reset(fo);
   if ioresult<>0 then error[p]:=3; {Not file output}
   reset(fi);
   reset(fm);
   {$i+}
end;

procedure DongFile;
begin
   {$i-};
   close(fi);
   close(fo);
   close(fm);
   {$i+}
end;

procedure Cham;
var sm, so: string;
procedure chuan(var s: string);
begin
   while (length(s)>0) and (s[1]=#32) do delete(s,1,1);
   while (length(s)>0) and (s[length(s)]=#32) do delete(s,length(s),1);
end;
begin
   readln(fm,sm);
   readln(fo,so);
   Chuan(sm);
   Chuan(so);
   if sm<>so then
      begin
         error[p]:=4; {wrong answer}
         exit;
      end;
   diem[p]:=10;
end;

procedure XoaFile;
begin
   {$i-}
   erase(ft);
   reset(fo);
   if ioresult=0 then
      begin
         close(fo);
         erase(fo);
      end;
   {$i+}
end;

procedure inkq;
var Tong: longint;
begin
   Tong:=0;
   for p:=1 to 10 do Tong:=Tong+diem[p];
   writeln;
   writeln('---------------------------------------------------------');
   writeln('|Test|Time(ms)|Memory(bytes)|         Error        |Diem|');
   writeln('|----|--------|-------------|----------------------|----|');
   for p:=1 to 10 do
      begin
         write('|');
         write(#32,p:2,#32,'|');
         write(Tg[p]:8,'|');
         write(Bn[p]:13,'|');
         case error[p] of
            0: write('Accepted              |');
            1: write('Memory Limit Excceded |');
            2: write('Time Limit Excceded   |');
            3: write('File output not found |');
            4: write('Wrong answer          |');
         end;
         writeln(diem[p]:4,'|');
      end;
   writeln('|--------------------------------------------------|----|');
   writeln('|Tong diem                                         |',Tong:4,'|');
   writeln('---------------------------------------------------------');
   writeln('Press any key to continue...');
   repeat until keypressed;
end;

procedure Main;
var s: string[2];
begin
   fillchar(diem,sizeof(diem),0);
   for p:=1 to 10 do
      begin
         str(p,s);
         if p<10 then s:='0'+s;
         tfi:=dtfi+s;
         tfo:=dtfo+s;
         tfm:=dtfm+s;
         tft:=dtft+s;
         error[p]:=0;
         GanFile;
         TimeMemory;
         if error[p]=0 then
            begin
               Mofile;
               if error[p]=0 then Cham;
               Dongfile;
            end;
         XoaFile;
      end;
   inkq;
end;

BEGIN
   Main;
END.
