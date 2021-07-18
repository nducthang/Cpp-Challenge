{*********************************************************************
*   Program   :   CHON O (SELECT)                                    *
*   Date      :   19-11-2006                                         *
*   Group     :   Qui hoach dong                                     *
*********************************************************************}
{$r+,q+}
const
   tfi                  =       'SELECT.INP';
   tfo                  =       'SELECT.OUT';

var
   fi, fo               :       text;
   f                    :       array[0..7,1..2] of longint;
   S                    :       longint;
   N                    :       longint;
   a                    :       array[1..4] of longint;

function max0:longint;
var x,i: longint;
begin
   x:=f[0,1];
   for i:=1 to 7 do
      if f[i,1]>x then x:=f[i,1];
   max0:=x;
end;

function max1(i: longint): longint;
var x,k: longint;
begin
   x:=f[0,1];
   for k:=1 to 4 do
      if (k<>i) and (f[k,1]>x) then x:=f[k,1];
   case i of
      1: if f[7,1]>x then x:=f[7,1];
      2: begin
            if f[5,1]>x then x:=f[5,1];
            if f[6,1]>x then x:=f[6,1];
         end;
      3: begin
            if f[6,1]>x then x:=f[6,1];
            if f[7,1]>x then x:=f[7,1];
         end;
      4: if f[5,1]>x then x:=f[5,1];
   end;
   max1:=x+a[i];
end;

function max2(i,j: longint): longint;
var x: longint;
begin
   x:=f[0,1];
   if (i=1) and (j=3) then
      begin
         if f[2,1]>x then x:=f[2,1];
         if f[4,1]>x then x:=f[4,1];
         if f[7,1]>x then x:=f[7,1];
         x:=x+a[1]+a[3];
      end;
   if (i=1) and (j=4) then
      begin
         if f[2,1]>x then x:=f[2,1];
         if f[3,1]>x then x:=f[3,1];
         x:=x+a[1]+a[4];
      end;
   if (i=2) and (j=4) then
      begin
         if f[1,1]>x then x:=f[1,1];
         if f[3,1]>x then x:=f[3,1];
         if f[5,1]>x then x:=f[5,1];
         x:=x+a[2]+a[4];
      end;
   max2:=x;
end;

procedure Xuly;
var i: longint;
begin
   for i:=0 to 7 do f[i,1]:=f[i,2];
   f[0][2]:=Max0;
   for i:=1 to 4 do f[i,2]:=max1(i);
   f[5,2]:=max2(1,3);
   f[6,2]:=max2(1,4);
   f[7,2]:=max2(2,4);
   for i:=0 to 7 do
      if f[i,2]>S then S:=f[i,2];
end;

procedure Main;
var i,j: longint;
begin
   assign(fi,tfi); reset(fi);
   assign(fo,tfo); rewrite(fo);
   for i:=0 to 7 do f[i,2]:=0;
   S:=-maxlongint;
   readln(fi,N);
   for j:=1 to N do
      begin
         for i:=1 to 4 do read(fi,a[i]);
         readln(fi);
         Xuly;
      end;
   writeln(fo,S);
   close(fi); close(fo);
end;

BEGIN
   Main;
END.