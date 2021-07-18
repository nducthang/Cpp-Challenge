{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt;

const
   tfi='CABLE.INP';
   tfo='CABLE.OUT';
   NN=25000;

type
   mang=array[1..13000] of LongInt;

var
   fi,fo: text;
   N: integer;
   a: array[1..2] of ^mang;
   S: array[1..2] of ^mang;

procedure SinhDL;
var ch: char;
    i: integer;
    u: word;
begin
   clrscr;
   writeln('Ban co tao file ',tfi,' (C/K)?');
   repeat ch:=readkey until upcase(ch) in ['C','K'];
   if upcase(ch)='K' then exit;
   randomize;
   N:=NN;
   assign(fi,tfi); rewrite(fi);
   writeln(fi,N);
   for i:=1 to N-1 do
      begin
         u:=65000;
         u:=random(u)+100;
         writeln(fi,u);
      end;
   close(fi);
end;

procedure CapPhat;
var i: integer;
begin
   for i:=1 to 2 do new(a[i]);
   for i:=1 to 2 do new(s[i]);
end;

procedure DoiDinh(i: integer; var u,v: integer);
begin
   u:=(i-1) div 13000+1;
   v:=(i-1) mod 13000+1;
end;

procedure Docdl;
var i,u,v: integer;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,N);
   for i:=1 to N-1 do
      begin
         DoiDinh(i,u,v);
         readln(fi,a[u]^[v]);
      end;
   close(fi);
end;

procedure XDB;
var i,u,v,u1,v1,u2,v2: integer;
begin
   s[1]^[1]:=0;
   s[1]^[2]:=a[1]^[1];
   s[1]^[3]:=a[1]^[1]+a[1]^[2];
   for i:=4 to N do
      begin
         DoiDinh(i,u,v);
         DoiDinh(i-1,u1,v1);
         DoiDinh(i-2,u2,v2);
         s[u]^[v]:=s[u1]^[v1]+a[u1]^[v1];
         if s[u]^[v]>s[u2]^[v2]+a[u1]^[v1] then
            s[u]^[v]:=s[u2]^[v2]+a[u1]^[v1];
      end;
end;

procedure Inkq;
var u,v: integer;
begin
   assign(fo,tfo); rewrite(fo);
   DoiDinh(n,u,v);
   writeln(fo,s[u]^[v]);
   close(fo);
end;

BEGIN
   CapPhat;
   {SinhDL;}
   Docdl;
   XDB;
   Inkq;
END.