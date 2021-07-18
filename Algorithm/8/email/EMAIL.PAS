{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt;


const
   tfi                  =       'EMAIL.INP';
   tfo                  =       'EMAIL.OUT';
   maxN                 =       50;
   NN                   =       50;

type
   mang=array[1..maxN] of byte;

var
  fi,fo: text;
  N: integer;
  a: array[1..maxN] of byte;
  S: integer;
  b: array[1..maxN,1..maxN] of ^mang;

procedure Docdl;
var i: integer;
begin
   assign(fi,tfi); reset(fi);
   read(fi,N);
   for i:=1 to N do read(fi,a[i]);
   close(fi);
end;

function Tinh(u,v,k: integer): byte;
var T: byte;
    p,q,tt,tp,tc: integer;
begin
   if b[u,v]^[k]<>255 then
      begin
         Tinh:=b[u,v]^[k];
         exit;
      end;
   if u=v then
      begin
         b[u,v]^[k]:=1;
         Tinh:=1;
         exit;
      end;
   if k=u then
      begin
         T:=255;
         for q:=u+1 to v do
            begin
               tp:=Tinh(u+1,v,q);
               if a[q]<>a[u] then tp:=tp+1;
               if tp<T then T:=tp;
            end;
         b[u,v]^[k]:=T;
         Tinh:=T;
         exit;
      end;
   if k=v then
      begin
         T:=255;
         for p:=u to v-1 do
            begin
               tt:=Tinh(u,v-1,p);
               if a[p]<>a[v] then tt:=tt+1;
               if tt<T then T:=tt;
            end;
         b[u,v]^[k]:=T;
         Tinh:=T;
         exit;
      end;
   T:=255;
   for p:=u to k-1 do
      for q:=k+1 to v do
         begin
            tt:=Tinh(u,k-1,p);
            tp:=Tinh(k+1,v,q);
            if (a[p]=a[k]) and (a[k]=a[q]) then tc:=tt+tp-1 else
            if (a[p]=a[k]) and (a[k]<>a[q]) then tc:=tt+tp else
            if (a[p]<>a[k]) and (a[k]=a[q]) then tc:=tt+tp else
            tc:=tt+tp+1;
            if tc<T then T:=tc;
         end;
   b[u,v]^[k]:=T;
   Tinh:=T;
end;

procedure Solve;
var k,T: integer;
begin
   S:=maxInt;
   for k:=1 to N do
       begin
          T:=Tinh(1,n,k);
          if T<S then S:=T;
       end;
end;

procedure Inkq;
begin
   assign(fo,tfo); rewrite(fo);
   writeln(fo,S);
   close(fo);
end;

procedure CapPhat;
var i,j,k: integer;
begin
   for i:=1 to NN do
      for j:=1 to NN do
         begin
            new(b[i,j]);
            for k:=1 to NN do b[i,j]^[k]:=255;
         end;
end;

BEGIN
   CapPhat;
   Docdl;
   Solve;
   Inkq;
END.