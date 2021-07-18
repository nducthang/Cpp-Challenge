{$M 4000 0 0}
program AutoTest;
uses crt, dos;
const
 f1 = 'C:\_TEMP\TAOTEST.EXE';
 f2 = 'C:\_TEMP\TH021.EXE';
 f3 = 'C:\_TEMP\CHAM021.EXE';
var
 c: Char;
begin
 repeat
  Exec(f1, '');
  Exec(f2, '');
  Exec(f3, '');
  Write('Co tiep khong ? ');
  c := Upcase(Readkey); Writeln(c);
 until c = 'K';
end.
