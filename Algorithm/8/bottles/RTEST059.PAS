program TaoTest;
const
  a: array['0'..'9'] of LongInt =
  (8, 10, 100, 1000, 10000, 100000, 999, 9999, 99999, 98765);
var
  i: Char;

procedure Create(i: Char);
var
  f: Text;
  j: LongInt;
begin
  Assign(f, 'BOTTLES.IN' + i); Rewrite(f);
  Writeln(f, a[i]);
  for j := 1 to a[i] do Writeln(f, Random(32767) + 1);
  Close(f);
end;

begin
  Randomize;
  for i := '0' to '9' do Create(i);
end.
