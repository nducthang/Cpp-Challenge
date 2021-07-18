{*********************************************************************
Program   : CHON DAY CON CO TONG LON NHAT TRONG DAY BAN DAU
Date      : 14-10-2005
Thuat toan: Qui hoach dong
*********************************************************************}
const
   tfi='CHONSO.INP';
   tfo='CHONSO.OUT';
   maxN=1000;

var
   fi, fo: text;
   N: integer;
   x,a,T,Tr: array[0..maxN] of longint;
   kt,count: integer;

procedure Docdl;
var i: integer;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,N);
   for i:=1 to N do readln(fi,a[i]);
   close(fi);
end;

procedure XDB;
var i: integer;
begin
   fillchar(T,sizeof(T),0);
   fillchar(Tr,sizeof(Tr),0);
   T[1]:=a[1];
   T[2]:=a[1]+a[2];
   if a[2]>a[1] then
      begin
         T[3]:=a[3]+a[2];
         Tr[3]:=2;
      end
   else
      begin
         T[3]:=a[3]+a[1];
         Tr[3]:=1;
      end;
   for i:=4 to N do
      begin
         T[i]:=a[i]+a[i-1]+T[i-3]; Tr[i]:=i-3;
         if T[i]<a[i]+a[i-1]+T[i-4] then
            begin
               T[i]:=a[i]+a[i-1]+T[i-4];
               Tr[i]:=i-4;
            end;
         if T[i]<a[i]+T[i-2] then
            begin
               T[i]:=a[i]+T[i-2];
               Tr[i]:=i-2;
            end;
      end;
end;

procedure XLB;
var i,u,v,w: integer;
begin
   kt:=n;
   for i:=1 to 2 do
      if T[kt]<T[n-i] then kt:=n-i;
   u:=kt;
   count:=0;
   while u>3 do
   begin
      v:=tr[u];
      if v=u-2 then
         begin
            inc(count);
            x[count]:=u;
         end
      else
         begin
            inc(count);
            x[count]:=u;
            inc(count);
            x[count]:=u-1;
         end;
      u:=v;
   end;
   case u of
      1: begin
            inc(count);
            x[count]:=1;
         end;
      2: begin
            inc(count); x[count]:=2;
            inc(count); x[count]:=1;
         end;
      3: begin
            v:=tr[u];
            inc(count); x[count]:=3;
            inc(count); x[count]:=v;
         end;
   end;
end;

procedure Inkq;
var u: integer;
begin
   assign(fo,tfo); rewrite(fo);
   writeln(fo,T[kt],' ',count);
   for u:=count downto 1 do writeln(fo,x[u]);
   close(fo);
end;

BEGIN
   Docdl;
   XDB;
   XLB;
   Inkq;
END.