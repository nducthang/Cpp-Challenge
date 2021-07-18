{*********************************************************************
* Program    :             BANK (Bai thay TUNG)                      *
* Date       :             05-11-2005                                *
* Thuat toan :             Qui hoach dong                            *
*********************************************************************}
{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt;

const
   tfi          =       'BANK.INP';
   tfo          =       'BANK.OUT';
   NN           =       100;
   maxN         =       100;
   maxV         =       2*(maxN+1);
   maxS         =       100;

type
   SoNguyen=string[maxS];

var
   a: array[1..3,1..maxN] of byte;
   n: integer;
   fi,fo: text;
   CS,TT: array[1..maxV] of integer;
   sTT: integer;
   Tr: array[1..maxV] of integer;
   S : array[1..maxV] of SoNguyen;
   x: array[1..maxV] of integer;
   slx: integer;
   Max: SoNguyen;
   AmMot,zero: SoNguyen;

procedure Sinhdl;
var ch: char;
    i,j: integer;
begin
   clrscr;
   writeln('Ban co tao file ',tfi,' (C/K)?');
   repeat ch:=readkey until upcase(ch) in ['C','K'];
   if upcase(ch)='K' then exit;
   randomize;
   N:=NN;
   assign(fi,tfi); rewrite(fi);
   writeln(fi,N);
   for i:=1 to 3 do
      begin
         for j:=1 to N do write(fi,random(2));
         writeln(fi);
      end;
   close(fi);
end;

procedure Gapdoi(var T: SoNguyen);
var nho,i,tich: integer;
begin
   nho:=0;
   for i:=maxS downto 1 do
      begin
         tich:=(ord(T[i])-48)*2+nho;
         T[i]:=chr(tich mod 10+48);
         nho:=tich div 10;
      end;
end;

procedure Cong(var T: SoNguyen; k: byte);
begin
   if k=0 then exit;
   T[maxS]:=succ(T[maxS]);
end;


function Doiso(k,i: integer): integer;
begin
   Doiso:=(k-1)*(n+1)+i+1;
end;

procedure Doidinh(u: integer; var k,i: integer);
begin
   k:=(u-1) div (n+1)+1;
   i:=(u-1) mod (n+1);
end;


procedure Docdl;
var i,j: integer;
    c: char;
begin
   fillchar(a,sizeof(a),0);
   assign(fi,tfi); reset(fi);
   readln(fi,n);
   for i:=1 to 3 do
      begin
         for j:=1 to n do
            begin
               read(fi,c);
               a[i,j]:=ord(c)-48;
            end;
         readln(fi);
      end;
   close(fi);
   zero:='';
   for i:=1 to maxS do zero:=zero+'0';
   AmMot:=zero;
   AmMot[1]:=Pred(AmMot[1]);
end;

procedure Loang(u: integer);
var v,k,i,j: integer;
begin
   TT[u]:=-1;
   Doidinh(u,k,i);
   for j:=i+1 to n do
      begin
         v:=Doiso(3-k,j);
         if TT[v]=0 then Loang(v);
      end;
   inc(sTT);
   TT[u]:=sTT;
   CS[2*(n+1)-sTT+1]:=u;
end;

procedure SxTopo;
var i: integer;
begin
   Fillchar(TT,sizeof(TT),0);
   Fillchar(CS,sizeof(CS),0);
   sTT:=0;
   for i:=1 to 2*(n+1) do
      if TT[i]=0 then
         Loang(i);
end;

function Ke(v,u: integer): boolean;
var k,l,i,j: integer;
begin
   Doidinh(CS[v],k,i);
   Doidinh(Cs[u],l,j);
   Ke:=(k+l=3) and (i<j);
end;

function Tong(v,u: integer): SoNguyen;
var k,l,i,j,r: integer;
    T: SoNguyen;
begin
   Doidinh(CS[v],k,i);
   Doidinh(CS[u],l,j);
   T:=S[v];
   if k=2 then k:=3;
   if l=2 then l:=3;
   for r:=i+1 to j do
      Begin
         Gapdoi(T);
         Cong(T,a[k,r]);
      end;
   for r:=j downto i+1 do
      begin
         GapDoi(T);
         Cong(T,a[2,r]);
      end;
   for r:=i+1 to j do
      begin
         GapDoi(T);
         Cong(T,a[l,r]);
      end;
   Tong:=T;
end;

procedure Tinh;
var i,u,v: integer;
    T: SoNguyen;
begin
   fillchar(Tr,sizeof(Tr),0);
   i:=0;
   repeat inc(i) until Cs[i]=1;
   Tr[i]:=-1; S[i]:=zero;
   for u:=i+1 to 2*(n+1) do
      begin
         Tr[u]:=-1;
         S[u]:=AmMot;
         for v:=u-1 downto i do
            if Ke(v,u) then
               begin
                  T:=Tong(v,u);
                  if T>S[u] then
                     begin
                        S[u]:=T;
                        Tr[u]:=v;
                     end;
               end;
      end;
end;

procedure TimDuong;
var i,u,v,kt: integer;
    
begin
   u:=Doiso(1,n);
   v:=Doiso(2,n);

   for i:=1 to 2*(n+1) do
      if (Cs[i]=u) then
         begin
            Max:=S[i];
            kt:=i;
            break;
         end;

   for i:=1 to 2*(n+1) do
      if (cs[i]=v) then
         begin
            if Max<S[i] then
               begin
                  Max:=S[i];
                  Kt:=i;
               end;
            break;
         end;

   slx:=0;
   u:=kt;
   repeat
      inc(slx);
      x[slx]:=Cs[u];
      u:=tr[u];
   until u=-1;
end;

procedure Indoan(u,v: integer);
var r,k,i,l,j: integer;
begin
   Doidinh(u,k,i);
   Doidinh(v,l,j);
   for r:=i+1 to j-1 do write(fo,'R');
   if k=1 then write(fo,'D') else write(fo,'U');
   for r:=j-1 downto i+1 do write(fo,'L');
   if k=1 then write(fo,'D') else write(fo,'U');
   for r:=i+1 to j-1 do write(fo,'R');
end;

procedure Inkq;
var i,u,v: integer;
begin
   assign(fo,tfo); rewrite(fo);
   for i:=slx downto 2 do
      begin
         u:=x[i]; v:=x[i-1];
         Indoan(u,v);
         if i>2 then write(fo,'R');
      end;
   close(fo);
end;

BEGIN
   {Sinhdl;}
   Docdl;
   SxTopo;
   Tinh;
   TimDuong;
   Inkq
END.