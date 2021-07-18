{$A+,B-,D+,E+,F-,G-,I-,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}

uses crt;

const
   tfi                  =       'CINEMA.INP';
   tfo                  =       'CINEMA.OUT';
   maxN                 =       50;
   maxK                 =       1000;
   Unseen               =       maxlongint div 2;

var
   fi,fo                :       text;
   n,m,k                :       longint;
   a                    :       array[1..maxN,1..maxN] of longint;
   f                    :       array[1..maxN] of longint;
   p                    :       array[1..maxK] of longint;
   Gr                   :       array[1..maxN,1..maxN] of byte;
   s,t                  :       array[1..maxN] of longint;
   Kt                   :       longint;
   GTMin                :       longint;
   x                    :       array[1..maxK] of longint;
   Tr                   :       array[1..maxK] of longint;

procedure Docdl;
var i,j,u,v,l: longint;
begin
   assign(fi,tfi); reset(fi);
   read(fi,n,m,k);
   for i:=1 to N do
      for j:=1 to N do a[i,j]:=Unseen;
   fillchar(Gr,sizeof(Gr),0);
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

procedure XDB;
var u,v,i: longint;
begin
   for u:=1 to N do s[u]:=Unseen;
   s[1]:=0;
   for i:=1 to K do
      begin
         t:=s;
         for u:=1 to N do s[u]:=Unseen;
         for u:=1 to N do
            if t[u]<Unseen then
               for v:=1 to N do
                  if (a[u,v]<Unseen) and (f[v]=p[i]) and (t[u]+a[u,v]<s[v]) then
                     s[v]:=t[u]+a[u,v];
      end;
   {Tim dinh ket thuc}
   GTMin:=Unseen;
   for u:=1 to N do
      if (f[u]=p[k]) and (s[u]<GTMin) then
         begin
            GTMin:=s[u];
            kt:=u;
         end;
end;

procedure Tim(u,v: longint);
var i,j,l: longint;
begin
   for i:=1 to N do s[i]:=Unseen;
   s[1]:=0;
   for i:=1 to u do
      begin
         t:=s;
         for j:=1 to N do s[j]:=Unseen;
         Fillchar(Tr,sizeof(Tr),0);
         for j:=1 to N do
            if (t[j]<Unseen) then
               for l:=1 to N do
                  if (f[l]=p[i]) and (a[j,l]<Unseen) and (t[j]+a[j,l]<s[l]) then
                     begin
                        s[l]:=t[j]+a[j,l];
                        Tr[l]:=j;
                     end;
      end;
end;

procedure XLB;
var v,u: longint;
begin
   v:=kt;
   for u:=K downto 1 do
      begin
         x[u]:=v;
         Tim(u,v);
         v:=Tr[v];
      end;
end;

procedure Inkq;
var i: longint;
begin
   assign(fo,tfo); rewrite(fo);
   writeln(fo,GTMin);
   for i:=1 to k do write(fo,x[i],' ');
   close(fo);
end;

BEGIN
   Docdl;
   Floy;
   XDB;
   XLB;
   Inkq;
END.