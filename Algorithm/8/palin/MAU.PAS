{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R-,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt;

const
   tfi          =       'PALIN.INP';
   tfo          =       'PALIN.OUT';
   maxN         =       5000;

var
   fi,fo        :       text;
   N            :       longint;
   c            :       array[1..maxN] of char;
   a,Tr         :       array[1..maxN] of longint;

procedure Docdl;
var i: longint;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,N);
   for i:=1 to N do read(fi,c[i]);
   close(fi);
end;

function max(u,v: longint): longint;
begin
   if u<v then max:=v else max:=u;
end;

procedure XDB;
var i,k,l: longint;
begin
   a[1]:=1; a[2]:=0;
   for i:=2 to N do
      begin
         Tr:=a;
         a[i]:=1; a[i+1]:=0;
         for k:=i-1 downto 1 do
            begin
               a[k]:=max(Tr[k],a[k+1]);
               if (c[k]=c[i]) and (a[k]<tr[k+1]+2) then
                  a[k]:=tr[k+1]+2;
            end;
      end;
end;

procedure Inkq;
begin
  assign(fo,tfo); rewrite(fo);
  writeln(fo,N-a[1]);
  close(fo);
end;

BEGIN
   Docdl;
   XDB;
   Inkq;
END.