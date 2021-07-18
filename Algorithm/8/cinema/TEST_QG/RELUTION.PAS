{**************************************************************************
*  Program   : XEM PHIM (Cinema - Thi V2 2003)                            *
*  Date      : 30-9-2006                                                  *
*  Group     : Do thi                                                     *
***************************************************************************}
uses crt;

const
   tfi                  =       'CINEMA.INP';
   tfo                  =       'CINEMA.OUT';
   maxN                 =       51;
   maxK                 =       1001;
   Unseen               =       maxlongint div 2;

type
   mang1=array[1..maxN,1..maxN] of longint;
   mang2=array[1..maxN] of byte;
   mang3=array[1..maxK] of byte;
   mang4=array[0..maxK] of longint;
   mang5=array[0..maxK] of byte;


var
   fi,fo                :       text;
   n,m,k: integer;
   a: mang1;
   f: mang2;
   p: mang3;
   kc: array[1..maxN] of ^mang4;
   Tr: array[1..maxN] of mang5;
   x: mang3;

procedure CapPhat;
var i: integer;
begin
   for i:=1 to maxN do new(kc[i]);
end;

procedure Nhap;
var i,j,u,v,l: longint;
begin
   assign(fi,tfi); reset(fi);
   read(fi,n,m,k);
   for i:=1 to N do
      for j:=1 to N do a[i,j]:=Unseen;
   for i:=1 to N do read(fi,f[i]);
   for j:=1 to m do
      begin
         read(fi,u,v,l);
         a[u,v]:=l;
         a[v,u]:=l;
      end;
   for i:=1 to K do read(fi,p[i]);
   close(fi);
end;

procedure Floy;
var i,u,v: longint;
begin
   for i:=1 to N do
      for u:=1 to N do
         for v:=1 to N do
            if a[u,v]>a[u,i]+a[i,v] then
               a[u,v]:=a[u,i]+a[i,v];
   for i:=1 to N do a[i,i]:=0;
end;

procedure Tinh;
var i,j,u: integer;
begin
   for i:=1 to n do
      for j:=0 to k do kc[i]^[j]:=Unseen;
   kc[1]^[0]:=0;
   for i:=1 to n do
      if (f[i]=p[1]) then
         begin
            kc[i]^[1]:=a[1,i];
            tr[i,1]:=1;
         end;
   for j:=1 to k-1 do
       for i:=1 to n do
          if kc[i]^[j]<Unseen then
             for u:=1 to n do
                if (a[i,u]<Unseen) and (f[u]=p[j+1]) and (kc[u]^[j+1]>kc[i]^[j]+a[i,u]) then
                   begin
                      kc[u]^[j+1]:=kc[i]^[j]+a[i,u];
                      Tr[u,j+1]:=i;
                   end;
end;

procedure Tim;
var i,j: integer;
begin
   x[k]:=1;
   for i:=2 to n do
      if kc[i]^[k]<kc[x[k]]^[k] then x[k]:=i;
   if kc[x[k]]^[k]=Unseen then exit;
   for j:=k-1 downto 1 do
      x[j]:=Tr[x[j+1],j+1];
end;

procedure Xuat;
var i: integer;
begin
   assign(fo,tfo); rewrite(fo);
   if kc[x[k]]^[k]=Unseen then writeln(fo,-1) else
      begin
         writeln(fo,kc[x[k]]^[k]);
         for i:=1 to K do write(fo,x[i],#32);
      end;
   close(fo);
end;

BEGIN
   CapPhat;
   Nhap;
   Floy;
   Tinh;
   Tim;
   Xuat;
END.