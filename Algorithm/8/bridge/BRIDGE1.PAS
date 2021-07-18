{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q-,R-,S-,T-,V+,X+,Y+}
{$M 16384,0,655360}
{*********************************************************************
* Program      :           CAU DA (Bai thay TUNG)                    *
* Date         :           04-11-2005                                *
* Thuat toan   :           Dem cau hinh to hop (Qui hoach dong)      *
**********************************************************************
{$N+,R-}
const
   tfi          =       'BRIDGE.INP';
   tfo          =       'BRIDGE.OUT';
   ONE          =       '00000000000000000000000000000000001';
   ZERO         =       '00000000000000000000000000000000000';

type
   xaukt        =       string[101];
   songuyen     =       string[35];

var
   fi, fo       :       text;
   mau          :       xaukt;
   s            :       array[1..2] of xaukt;
   M,N          :       integer;
   a            :       array[1..2,1..100] of Songuyen;
   kq           :       songuyen;


procedure Cong(var u,v: SoNguyen);
var i, nho, tong: integer;
begin
   nho:=0;
   for i:=35 downto 1 do
      begin
         tong:=nho+ord(u[i])+ord(v[i])-96;
         u[i]:=chr(48+tong mod 10);
         nho:=tong div 10;
      end;
end;


procedure Docdl;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,mau);
   readln(fi,s[1]);
   readln(fi,s[2]);
   close(fi);
end;

procedure XDB;
var l,i,j: integer;
begin
   m:=length(mau);
   n:=length(s[1]);
   for j:=1 to N do
      begin
         if s[1][j]=mau[1] then a[1,j]:=ONE else a[1,j]:=ZERO;
         if s[2][j]=mau[1] then a[2,j]:=ONE else a[2,j]:=ZERO;
      end;
   for i:=2 to m do
      for j:=N downto i do
         begin
            a[1,j]:=ZERO;
            if s[1][j]=mau[i] then
               for l:=j-1 downto i-1 do
                  Cong(a[1,j],a[2,l]); {a[1,j]:=a[1,j]+a[2,l];}
            a[2,j]:=ZERO;
            if s[2][j]=mau[i] then
               for l:=j-1 downto i-1 do
                  Cong(a[2,j],a[1,l]); {a[2,j]:=a[2,j]+a[1,l];}
         end;
end;

procedure XLB;
var i: integer;
begin
   kq:=ZERO;
   for i:=m to n do
      begin
          Cong(kq,a[1,i]);
          Cong(kq,a[2,i]);
      end;
end;

procedure Inkq;
begin
   while (kq[1]='0') and (length(kq)>1) do delete(kq,1,1);
   assign(fo,tfo); rewrite(fo);
   writeln(fo,kq);
   close(fo);
end;

BEGIN
   Docdl;
   XDB;
   XLB;
   Inkq;
END.