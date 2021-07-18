program CarGroup;
const
  InputFile  = 'CARGROUP.INP';
  OutputFile = 'CARGROUP.OUT';
  max = 1000;
  maxReal = 1E10;
var
  T: array[1..max] of Real;
  W: array[1..max] of Byte;
  n, P: Integer;
  F: array[0..max] of Real;
  EndofPrevGroup: array[1..max] of Integer;

procedure Enter;
var
  fi: Text;
  L, i, v: Integer;
begin
  Assign(fi, InputFile); Reset(fi);
  Readln(fi, n, P, L);
  for i := 1 to n do
    begin
      Readln(fi, w[i], v);
      t[i] := L / v;
    end;
  Close(fi);
end;

procedure Optimize;
var
  i, j, k, TotalW: Integer;
  MaxTime: Real;
begin
  F[0] := 0;
  for i := 1 to n do
    begin
      F[i] := maxReal; TotalW := 0; MaxTime := 0;
      for j := i downto 1 do
        begin
          TotalW := TotalW + W[j];
          if TotalW > P then Break;
          if MaxTime < T[j] then MaxTime := T[j];
          if F[i] > F[j - 1] + MaxTime then
            begin
              F[i] := F[j - 1] + MaxTime;
              EndofPrevGroup[i] := j - 1;
            end;
        end;
    end;
end;

procedure Result;
var
  fo: Text;
  Stack: array[1..max] of Integer;
  i, k, nStack: Integer;
begin
  Assign(fo, OutputFile); Rewrite(fo);
  Writeln(fo, F[n]:1:2);
  nStack := 1; Stack[1] := n;
  k := n;
  repeat
    k := EndOfPrevGroup[k];
    if k = 0 then Break;
    Inc(nStack);
    Stack[nStack] := k;
  until False;
  for i := nStack downto 1 do Write(fo, Stack[i], ' ');
  Close(fo);
end;

begin
  Enter;
  Optimize;
  Result;
end.
10 100 100
40 25
50 20
50 20
70 10
12 50
09 70
49 30
38 25
27 50
19 70

10 100 100
90 1
10 90
90 1
10 90
90 1
10 90
90 1
10 90
90 1
10 90
