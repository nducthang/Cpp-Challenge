{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt,Dos;

var
   Diem         :       array[0..9] of real;
   Error        :       array[0..9] of LongInt;
   p            :       LongInt;
   tfi,tfm,tfo  :       string[12];
   fi,fo,fm     :       text;
   d            :       SearchRec;
   Smau         :       array[0..9] of LongInt;
   N            :       LongInt;
   Sout         :       array[0..9] of LongInt;
   dd           :       array[1..25000] of byte;

procedure DocMau;
begin
   reset(fm);
   readln(fm,Smau[p],N);
   close(fm);
end;

function Ba(u: LongInt): boolean;
begin
   Ba:=(dd[u]+dd[u+1]+dd[u+2]=3);
end;

procedure Cham;
var i,dem,u,v: LongInt;
    T: LongInt;
    Ts: real;
begin
   readln(fo,Sout[p]);
   if IOResult<>0 then
      begin
         Error[p]:=2;
         exit;
      end;
   Fillchar(dd,sizeof(dd),0);
   dem:=0;
   u:=0;
   while not seekeoln(fo) do
      begin
         inc(dem);
         read(fo,v);
         if IOResult<>0 then
            begin
               Error[p]:=2; {Loi doc Output}
               exit;
            end;
         if v<=u then
            begin
               Error[p]:=3; {Khong tang dan}
               exit;
            end;
         if (v<1) or (v>N) then
            begin
               Error[p]:=4; {Sai so hieu}
               exit;
            end;
         if dd[v]=1 then
            begin
               Error[p]:=5; {Chon 2 lan}
               exit;
            end;
         dd[v]:=1;
         u:=v;
         if dem mod 10=0 then readln(fo);
      end;

   {Kiem tra xem co vi pham 3 lan lien tiep}
   for i:=3 to N-2 do
      if Ba(i-2) or Ba(i-1) or Ba(i) then
         begin
            Error[p]:=6; {Co ba VT lien tiep}
            exit;
         end;

   {Kiem tra Sout}
   T:=0;
   reset(fi);
   readln(fi,N);
   for i:=1 to N do
      begin
         readln(fi,u);
         if dd[i]=1 then T:=T+u;
      end;
   close(fi);
   if T<>Sout[p] then
      begin
         Error[p]:=7; {Tinh tong sai}
         exit;
      end;
   ts:=T/Smau[p];
   if T>=1.0 then Diem[p]:=1.0 else
   if T>=0.9 then Diem[p]:=0.5 else
   if T>=0.8 then Diem[p]:=0.3 else
   if T>=0.7 then Diem[p]:=0.1 else Diem[p]:=0.0;
end;

procedure InError(u: LongInt);
begin
   textcolor(red);
   case Error[u] of
      0: write('                              ');
      1: write('Khong file Output             ');
      2: write('Doc file bi loi               ');
      3: write('So hieu khong tang dan        ');
      4: write('So hieu khong hop le          ');
      5: write('So hieu bi in trung           ');
      6: write('Co 3 phan tu lien tiep        ');
      7: write('Tinh tong sai                 ');
   end;
   textcolor(white);
   writeln('|');
end;

procedure Inkq;
var T: real;
    i,u: LongInt;
begin
   clrscr;
   writeln;
   writeln;
   writeln;
   textcolor(white);
   writeln('        ******************************************************************');
   writeln('        *           KET QUA CHAM BAI CHON PHAN THUONG - BAI SO 2         *');
   writeln('        ******************************************************************');
   writeln('        |TEST| Ket qua  |    Mau   | Diem |     Ghi Chu                  |');
   writeln('        ------------------------------------------------------------------');
   T:=0.0;
   for i:=1 to 10 do
      begin
         u:=i mod 10;
         write('        |',u:3,' |',Sout[u]:10,'|',Smau[u]:10,'|',Diem[u]:5:1,' |');
         InError(u);
         T:=T+Diem[u];
      end;
   writeln('        ------------------------------------------------------------------');
   textcolor(Green);
   Writeln('              TONG CONG            = ',T:4:1,' Diem');
   textcolor(White);
end;


BEGIN
   {$I-}
   Fillchar(Diem,sizeof(Diem),0);
   Fillchar(Error,sizeof(Error),0);
   for p:=0 to 9 do
      begin
         tfi:='PTHUONG.IN'+chr(p+48);
         tfm:='PTHUONG.AS'+chr(p+48);
         tfo:='PTHUONG.OU'+chr(p+48);
         assign(fi,tfi); assign(fo,tfo); assign(fm,tfm);
         DocMau;
         FindFirst(tfo,Archive,d);
         if DosError<>0 then
            begin
               Error[p]:=1; {Khong co file output}
               continue;
            end;
         reset(fo);
         Cham;
         close(fo);
         erase(fo);
      end;
   Inkq;
END.