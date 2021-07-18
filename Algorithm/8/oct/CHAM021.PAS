{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O+,P-,Q-,R-,S-,T-,V+,X+,Y+}
{$M 16384,0,655360}
program Cham021;
const
 InputFile  = 'OCT.INP';
 OutputFile = 'OCT.OUT';
var
 a: array[0..7, 0..7] of Byte;
 X: array[1..201] of Byte;
 n, EndValue: Byte;

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
 Readln(f, EndValue);
 Close(f);
end;

function Check: Boolean;
var
 f: Text;
 i, p: Byte;
begin
 Assign(f, OutputFile); Reset(f);
 for i := 1 to n - 1 do
  begin
   Read(f, p);
   x[p] := a[x[p], x[p + 1]];
   Move(x[p + 2], x[p + 1], n - p - 1);
  end;
 Close(f);
 Check := x[1] = EndValue;
end;

begin
 Enter;
 Writeln(Check);
end.
