{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
uses crt;

const
   dh: array[1..5] of integer=(0,-1,0,1,0);
   dc: array[1..5] of integer=(1,0,-1,0,0);
   GT: array[0..3,0..3] of byte=((0,3,2,1),
                                 (1,0,3,2),
                                 (2,1,0,3),
                                 (3,2,1,0));
   TgMau: array[0..9] of integer=(59,18,18,36,39,37,57,73,78,58);

var tt: integer;
    tfi,tfo: string[12];
    fi,fo: text;
    a: array[1..50,1..50] of byte;
    M,N: integer;
    TgOut: integer;
    ok: boolean;
    hs,diem: array[0..9] of real;

procedure Docdl;
var i,j: integer;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,M,N);
   for i:=1 to M do
      begin
         for j:=1 to N do read(fi,a[i,j]);
         readln(fi);
      end;
   close(fi);
end;

function Outside(i,j: integer): boolean;
begin
   Outside:=(i<1) or (i>m) or (j<1) or (j>n);
end;

procedure Dockq;
var u,v,i,k: integer;
    c: char;
begin
   readln(fo,TgOut);
   ok:=false;
   u:=M; v:=1;
   for i:=1 to TgOut do
      begin
         read(fo,c);
         case c of
            'E': k:=1;
            'N': k:=2;
            'W': k:=3;
            'S': k:=4;
            'P': k:=5;
         end;
         u:=u+dh[k]; v:=v+dc[k];
         if Outside(u,v) or (GT[a[u,v],i mod 4]=0) then exit;
      end;
   if (u<>1) or (v<>N) then exit;
   ok:=true;
end;

procedure TinhDiem;
begin
   if not ok then
   begin
      hs[tt]:=10;
      Diem[tt]:=0.0
   end else
      begin
         hs[tt]:=TgOut/TgMau[tt];
         if hs[tt]<=1 then Diem[tt]:=1.0 else
         if hs[tt]<=1.1 then Diem[tt]:=0.5 else
         if hs[tt]<=1.2 then Diem[tt]:=0.4 else
         if hs[tt]<=1.3 then Diem[tt]:=0.3 else
         if hs[tt]<=1.4 then Diem[tt]:=0.2 else Diem[tt]:=0.1;
      end;
end;

procedure Inkq;
var Tong: real;
    i,k: integer;
begin
   Tong:=0;
   for i:=0 to 9 do Tong:=Tong+Diem[i];
   clrscr;
   writeln; writeln;writeln;
   writeln('               ***************************************************');
   writeln('               *        KET QUA CHAM BAI HANH TINH DAM LAY       *');
   writeln('               ***************************************************');
   for k:=1 to 10 do
      begin
         i:=k mod 10;
         writeln('               TEST so ',i,'  =  ',Diem[i]:0:2,' diem. Ty le:',hs[i]:0:3);
      end;
   writeln('               ---------------------------------------------------');
   writeln('                 Tong diem =',Tong:0:2,' diem');
   readln;
end;

BEGIN
   clrscr;
   for tt:=0 to 9 do
      begin
         tfi:='FEN.IN'+chr(tt+48);
         tfo:='FEN.OU'+chr(tt+48);
         Docdl;
         {$I-}
         assign(fo,tfo); reset(fo);
         if IOResult<>0 then
            begin
               {$I+}
               continue;
            end;
         Dockq;
         close(fo);
         erase(fo);
         TinhDiem;
         {$I+}
      end;
   inkq;
END.