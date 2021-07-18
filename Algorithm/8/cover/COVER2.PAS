{$R+,q+}
const
 nfi='cover.inp';
 nfo='cover.out';
 limit=30000;
 limitn=100;
type
 mang=array[1..100] of longint;
var
 fi,fo: text;
 d: array[1..limit] of integer;
 st: array[1..300] of ^mang;
 n,a,b,dd,sl: integer;
procedure openfile;
 begin
  assign(fi,nfi); reset(fi);
  assign(fo,nfo); rewrite(fo);
 end;
procedure closefile;
 begin
  close(fi); close(fo);
 end;
procedure input;
 var
  i,u,v,j: integer;
 begin
  for i:=1 to 30000 do
   d[i]:=0;
  for i:=1 to 300 do
   new(st[i]);
  readln(fi,n,a,b);
  for i:=1 to 300 do
   for j:=1 to 100 do
    st[i]^[j]:=0;
  for i:=1 to n do
    begin
     readln(fi,u,v);
     if d[u]<v then
      begin
       d[u]:=v;
       st[(u-1) div limitn+1]^[(u-1) mod limitn+1]:=i;
      end;
    end;
    dd:=a;
 end;
procedure process1;
 var
  i,max,cs,k: integer;
 begin
  cs:=1;
  sl:=0;
  repeat
   k:=0;
   max:=0;
   for i:=cs to a do
     if d[i]>0 then
      if max<d[i] then
       begin
        max:=d[i];
        k:=i;
       end;
   if k=0 then exit;
   inc(sl);
   a:=d[k];
   cs:=k+1;
  until a>=b;
 end;
procedure process2;
 var
  i,max,cs,sl,k: integer;
 begin
  a:=dd;
  cs:=1;
  repeat
   k:=0;
   max:=0;
   for i:=cs to a do
     if d[i]>0 then
      if max<d[i] then
       begin
        max:=d[i];
        k:=i;
       end;
   if k=0 then exit;
   writeln(fo,st[(k-1) div limitn+1]^[(k-1) mod limitn+1]);
   a:=d[k];
   cs:=k+1;
  until a>=b;
 end;
procedure output;
 begin
  if a<b then write(fo,-1)
   else
    begin
     writeln(fo,sl);
     process2;
    end;
 end;
begin
 openfile;
 input;
 process1;
 output;
 closefile;
end.