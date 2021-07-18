{$N+,E+}
program Bottles;
const
  InputFile  = 'BOTTLES.INP';
  OutputFile = 'BOTTLES.OUT';
  maxN = 100000;
var
  fi: Text;
  dWindow: array[1..3] of Comp;
  cWindow: array[1..3] of LongInt;
  Total: Comp;
  Trace: array[0..maxN div 2 + 1] of Byte;
  n: LongInt;

function GetTrace(i: LongInt): Byte;
begin
  if Odd(i) then GetTrace := Trace[i shr 1] shr 4
  else GetTrace := Trace[i shr 1] and $F;
end;

procedure SetTrace(i: LongInt; v: Byte);
begin
  if Odd(i) then Trace[i shr 1] := Trace[i shr 1] or v shl 4
  else Trace[i shr 1] := Trace[i shr 1] or v;
end;

procedure Init;
var
  i: Integer;
begin
  FillChar(dWindow, SizeOf(dWindow), 0);
  FillChar(cWindow, SizeOf(cWindow), 0);
  FillChar(Trace, SizeOf(Trace), 0);
  Total := 0;
end;

procedure Optimize;
var
  i: LongInt;
  k: LongInt;
  j, jmin: Integer;
  newD: Comp;
  newC: LongInt;
begin
  for i := 1 to n + 1 do
    begin
      if i <= n then Read(fi, k)
      else k := 0;
      Total := Total + k;
      jmin := 1;
      for j := 2 to 3 do
        if dWindow[j] < dWindow[jmin] then jmin := j;
      newD := dWindow[jmin] + k;
      newC := cWindow[jmin] + 1;
      Move(dWindow[1], dWindow[2], SizeOf(dWindow[1]) * 2);
      Move(cWindow[1], cWindow[2], SizeOf(cWindow[1]) * 2);
      dWindow[1] := newD;
      cWindow[1] := newC;
      SetTrace(i, jmin);
    end;
end;

procedure Result;
var
  fo: Text;
  k, i: LongInt;
  d: Integer;
begin
  Assign(fo, OutputFile); Rewrite(fo);
  Writeln(fo, n + 1 - cWindow[1], ' ',Total - dWindow[1]:1:0);
  k := n + 1;
  repeat
    d := GetTrace(k);
    for i := k - 1 downto k - d + 1 do Writeln(fo, i);
    k := k - d;
  until k = 0;
  Close(fo);
end;

begin
  Init;
  Assign(fi, InputFile); Reset(fi);
  Readln(fi, n);
  Optimize;
  Close(fi);
  Result;
end.
