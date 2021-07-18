program Cover;
uses crt, visual;
const
  InputFile: string  = 'COVER.IN';
  OutputFile = 'COVER.OUT';
  maxV = 30000;
  maxN = 100000;
type
  TArray = array[1..maxV] of Integer;
  TMark = array[0..maxN div 8] of set of 0..7;
var
  Right: ^TArray;
  Mark: TMark;
  n: LongInt;
  a, b, res: Integer;
  f: Text;
  ch: Char;

procedure Init;
begin
  New(Right);
  FillChar(Right^, SizeOf(Right^), 0);
end;

procedure ReadInput;
var
  f: Text;
  i: LongInt;
  l, r: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, a, b);
  for i := 1 to n do
    begin
      Readln(f, l, r);
      if l < a then l := a;
      if r > b then r := b;
      if l > r then Continue;
      if Right^[l] < r then
        Right^[l] := r;
    end;
  Close(f);
end;

procedure ReReadInput;
var
  f: Text;
  i, seg, ofs: LongInt;
  l, r: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, a, b);
  for i := 1 to n do
    begin
      Readln(f, l, r);
      seg := i shr 3;
      ofs := i and 7;
      if not (ofs in Mark[seg]) then Continue;
      if l < a then l := a;
      if r > b then r := b;
      if l > r then Continue;
      if Right^[l] < r then
        Right^[l] := r;
    end;
  Close(f);
end;

procedure Count;
var
  t, Covered, Expect: Integer;
begin
  Covered := a - 1;
  Expect := Right^[a];
  res := 0;
  for t := a to b do
    begin
      if t > Covered then {diem t chua duoc phu}
        begin
          if t > Expect then {Khong the phu duoc t}
            begin
              res := -1; Exit;
            end;
          Inc(res);          {Can them 1 doan de:        }
          Covered := Expect; {  Phu qua t, den tan Expect}
        end;
      if Right^[t] > Expect then Expect := Right^[t]; {Lay Expect moi}
    end;
end;

procedure Halt;
begin
  {$I-}
  Close(f); if IOResult = 0 then;
  {$I+}
  ReadKey;
  TextMode(C80); Textattr := 7; Clrscr;
  System.Halt;
end;

procedure WriteP(p: Integer);
var
  f: file of Integer;
begin
  Assign(f, 'POINT.PNT'); Rewrite(f);
  Write(f, p);
  Close(f);
end;

function ReadP: Integer;
var
  f: file of Integer;
  P: Integer;
begin
  {$I-}
  Assign(f, 'POINT.PNT'); Reset(f);
  if IOResult <> 0 then
    begin
      WriteP(0);
      Reset(f);
    end;
  {$I+}
  Read(f, p);
  Close(f);
  ReadP := p;
end;

procedure ShowP;
var
  S: String;
begin
  Str(ReadP, S);
  if Length(S) < 2 then S := '0' + S;
  Visual.Color := 30;
  MSG(60, 3, 'Tæng', 'Tæng ®iÓm ®ang lµ ' + S + '/10');
end;

procedure Correct;
begin
  Visual.Color := 47;
  MSG(20, 3, InputFile, '   B¹n cã 1 ®iÓm   ');
  WriteP(ReadP + 1);
  ShowP;
  if ReadP = 10 then
    Logo('§óng hÕt c¸c test', 'Perfect! Perfect!');
  Halt;
end;

procedure Wrong;
begin
  Visual.Color := 78;
  MSG(20, 3, InputFile, '   B¹n cã 0 ®iÓm   '#7);
  ShowP;
  Halt;
end;

procedure AskTest;
var
  S: String[1];
begin
  Caption('Bµi 118: "Phñ ®o¹n"');
  MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: ' + InputFile + '  '#8#8);
  if (ParamCount <> 0) and (ParamStr(1) <> '') then
    begin
      S := ParamStr(1);
      ch := S[1];
    end
  else  ch := ReadKey;
  Write(ch);
  if ch = '1' then WriteP(0);
  if ch = #13 then
    begin
      MSG(40, 13, '§iÓm', 'Tæng ®iÓm cña b¹n ®ang lµ:  '#8#8);
      Write(ReadP);
      Halt;
    end;
  InputFile := InputFile + ch;
end;

procedure Test;
var
  i, k, HSRes, seg, ofs: LongInt;
begin
  Caption('ChÊm bµi 118: "Phñ ®o¹n"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, HSRes);
  Writeln('KiÓm tra sè ®o¹n phñ:');
  Writeln('  + §¸p ¸n      : ', res);
  Writeln('  + Häc sinh    : ', HSRes);
  if (res <> -1) and (HSRes > res) then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  if (res <> -1) and (HSRes = -1) then
    begin
      Writeln('KÕt qu¶ sai!');
      Wrong;
    end;
  if (res = -1) and (HSRes = -1) then
    begin
      Writeln('KÕt qu¶ ®óng!');
      Correct;
    end;
  Writeln('KiÓm tra phñ...');
  FillChar(Mark, SizeOf(Mark), 0);
  for i := 1 to HSRes do
    begin
      Readln(f, k);
      if (k < 1) or (k > n) then
        begin
          Writeln('ChØ sè ®o¹n thø ', i, ' bÞ lçi ( = ', k, ')');
          Wrong;
        end;
      seg := k shr 3;
      ofs := k and 7;
      Include(Mark[seg], (ofs));
    end;
  Init;
  ReReadInput;
  Count;
  if res = -1 then
    begin
      Writeln('  Phñ kh«ng hÕt!');
      Wrong;
    end;
  Writeln('  Phñ hîp lÖ!');
  Correct;
end;

begin
  AskTest;
  Init;
  ReadInput;
  Count;
  Dispose(Right);
  Test;
end.

7 2 10
4 8
1 3
2 3
1 4
3 4
7 10
9 11