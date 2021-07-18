program RandomTest;
uses crt;
var
  f: Text;

procedure Assign(var f: Text; FileName: string);
begin
  Write('Creating ', FileName, '...');
  System.Assign(f, FileName);
end;

procedure Close(var f: Text);
begin
  Writeln('Done');
  System.Close(f);
end;

procedure CreateTest1;
begin
  Assign(f, 'COVER.IN1'); Rewrite(f);
  Writeln(f, '8 2000 10000');
  Writeln(f, '4000 8000');
  Writeln(f, '1000 3000');
  Writeln(f, '2000 3000');
  Writeln(f, '1000 4000');
  Writeln(f, '3000 4000');
  Writeln(f, '7000 10000');
  Writeln(f, '9000 11000');
  Writeln(f, '8000 11000');
  Close(f);
end;

procedure CreateTest2;
begin
  Assign(f, 'COVER.IN2'); Rewrite(f);
  Writeln(f, '8 2 555');
  Writeln(f, '1 4');
  Writeln(f, '2 5');
  Writeln(f, '4 5');
  Writeln(f, '6 45');
  Writeln(f, '6 7');
  Writeln(f, '5 7');
  Writeln(f, '100 200');
  Writeln(f, '50 101');
  Close(f);
end;

procedure CreateTest3;
var
  i: Integer;
begin
  Assign(f, 'COVER.IN3'); Rewrite(f);
  Writeln(f, '30000 1 30000');
  for i := 1 to 29995 do Writeln(f, i, ' ', i + 5);
  Writeln(f, '1 100');
  Writeln(f, '99 200');
  Writeln(f, '199 300');
  Writeln(f, '299 400');
  Writeln(f, '20001 30000');
  Close(f);
end;

procedure CreateRandomTest(FileName: string; n: LongInt;
          a, b, l: Integer);
var
  i, x, y, inf, sup: LongInt;
begin
  Assign(f, FileName); Rewrite(f);
  Writeln(f, n, ' ', a, ' ', b);
  inf := a - (b - a);
  if inf < 1 then inf := 1;
  sup := LongInt(b) + (b - a);
  if sup > 30000 then sup := 30000;
  for i := 1 to n do
    begin
      repeat
        x := inf + Random(sup - inf + 1);
        y := x + Random(l);
      until (y <= 30000);
      Writeln(f, x, ' ', y);
    end;
  Close(f);
end;

procedure CreateDiscreteTest;
var
  i: Integer;
begin
  Assign(f, 'COVER.IN7'); Rewrite(f);
  Writeln(f, 30000, ' ', 9999, ' ', 9999);
  for i := 1 to 30000 do
    Writeln(f, i, ' ', i);
  Close(f);
end;

begin
  Randomize;
  ClrScr;
  CreateTest1;
  CreateTest2;
  CreateTest3;
  CreateRandomTest('COVER.IN4', 1000, 100, 500, 20);
  CreateRandomTest('COVER.IN5', 10000, 1000, 9999, 999);
  CreateRandomTest('COVER.IN6', 50000, 99, 29999, 2002);
  CreateDiscreteTest;
  CreateRandomTest('COVER.IN8', 80000, 99, 29999, 10000);
  CreateRandomTest('COVER.IN9', 90000, 1234, 5678, 1000);
  CreateRandomTest('COVER.IN0', 100000, 1234, 29876, 1000);
end.