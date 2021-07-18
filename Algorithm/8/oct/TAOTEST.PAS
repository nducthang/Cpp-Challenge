{$R+}
program TaoTest;
const
 max = 200;
var
 i, j, x, y: Byte;
 a: array[0..7, 0..7] of Byte;
 f: Text;
 S: array[1..max + 1] of Byte;
 n: Byte;
begin
 Randomize;
 for i := 0 to 7 do
  for j := 0 to 7 do a[i, j] := Random(8);
 

 Assign(f, 'OCT.INP'); Rewrite(f);
 for i := 0 to 7 do
  begin
   for j := 0 to 7 do Write(f, a[i, j],' ');
   Writeln(f);
  end;

 Write('n = '); Readln(n);
 for i := 1 to n do S[i] := Random(8);
 Writeln(f, n);
 for i := 1 to n do Write(F, S[i], ' ');

 for i := 1 to n - 1 do
  begin
   j := Random(n - 1) + 1;
   S[j] := a[S[j], S[j +1]];
   Move(S[j + 2], S[j + 1], n - j - 1);
   Dec(n);
  end;


 Writeln(f);
 Write(f, S[1]);
 Close(f);
end.
