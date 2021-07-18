program OctArray;
const
 max = 200;
 InputFile  = 'OCT.INP';
 OutputFile = 'OCT.OUT';
 bits: array[0..7] of Byte = (1, 2, 4, 8, 16, 32, 64, 128);{Bits[i] = 1 SHL i}
type
 TOct = 0..7;
var
 a: array[TOct, TOct] of TOct;
 b: array[1..max, 1..max] of Byte;
 x: array[1..max] of TOct;
 n: Byte;
 e: TOct;
 f: Text;
 Time: LongInt absolute 0:$46C;
 OldTime: LongInt;

procedure Enter;
var
 f: Text;
 i, j: Byte;
begin
 Assign(f, InputFile); Reset(f);
 for i := 0 to 7 do
  begin
   for j := 0 to 7 do Read(f, a[i, j]);
   Readln(f);
  end;
 Readln(f, n);
 for i := 1 to n do Read(f, x[i]);
 Readln(f);
 Readln(f, e);
 Close(f);
end;

function GetBit(V: Byte; BitIndex: TOct): Byte;
begin
 if V and Bits[BitIndex] <> 0 then GetBit := 1
 else GetBit := 0;
end;

procedure Init;
var
 i: Byte;
begin
 FillChar(b, SizeOf(b), 0);
 for i := 1 to n do b[i, i] := bits[x[i]];
 Assign(f, OutputFile); Rewrite(f);
end;

function Generated(Set1, Set2: Byte): Byte;
var
 i, j, Result: Byte;
begin
 Result := 0;
 for i := 0 to 7 do
  if GetBit(Set1, i) = 1 then
   for j := 0 to 7 do
    if GetBit(Set2, j) = 1 then
     Result := Result or bits[a[i, j]];
 Generated := Result;
end;

procedure Optimize;
var
 i, j, k, l: Byte;
begin
 for l := 2 to n do
  for i := 1 to n - l + 1 do
   begin
    j := i + l - 1; {Tinh b[i, j]}
    for k := i to j - 1 do
     b[i, j] := b[i, j] or Generated(b[i, k], b[k + 1, j]);
   end;
end;

procedure FindMeasure(Left, Right: Byte; EndValue: TOct;
                      var vBegin, vEnd: TOct; var vPost: Byte);
var
 k, i, j: Byte;
begin
 for k := Left to Right - 1 do
  for i := 0 to 7 do
   for j := 0 to 7 do
     if (a[i, j] = EndValue) and
        (GetBit(b[Left, k], i) = 1) and
        (GetBit(b[k + 1, Right], j) = 1) then
      begin
       vBegin := i; vEnd := j; vPost := k;
       Exit;
      end;
end;

procedure Trace(l, r: Byte; EndValue: TOct);
var
 p: Byte;
 v1, v2: TOct;
begin
 if l < r then
  begin
   FindMeasure(l, r, EndValue, v1, v2, p);
   Trace(p + 1, r, v2);
   Trace(l, p, v1);
   Write(f, l, ' ');
  end;
end;

procedure PrintResult;
begin
 if b[1, n] and bits[e] = 0 then Write(f, 0)
 else
  Trace(1, n, e);
end;

begin
 OldTime := Time;
 Enter;
 Init;
 Optimize;
 PrintResult;
 Close(f);
 Writeln('Time: ', (Time - OldTime) / 18.2 :1:2);
end.
