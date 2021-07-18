uses crt;
const
  InputFile  = 'CARGROUP.IN';
  OutputFile = 'CARGROUP.OU';
  max = 1000;
  maxReal = 1E10;
var
  T: array[1..max] of Real;
  W: array[1..max] of Byte;
  n, P, diem: Integer;
  F: array[0..max] of Real;
  EndofPrevGroup: array[1..max] of Integer;
  c : Char;

procedure Enter;
var
  fi: Text;
  L, i, v: Integer;
begin
  Assign(fi, InputFile + c); Reset(fi);
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

procedure Display;
begin
 clrscr;
 writeln('                          CHAM BAI CARGROUP');
 writeln('        ======================================================');
 writeln; writeln; writeln;
 writeln(' TEST : CARGROUP.IN'+c);
 writeln('***************************');
end;

procedure error(s : string);
begin
 writeln(#7, s);
 readln;
end;

procedure Check;
var
 g : text;
 res : real;
begin
 assign(g, outputfile+c); reset(g);
 readln(g, res);
 writeln(' Ket qua cua DA : ', f[n] : 0 : 2);
 writeln(' Ket qua cua HS : ', res : 0 : 2);
 writeln('---------------------------');
 if trunc(res - f[n]) > 1 then
  begin
    error(' Diem cua test : 0!');
    close(g);
    exit;
  end;
 inc(diem);
 writeln(' Diem cua test : 1 !');
 readln;
 close(g);
end;

begin
  diem := 0;
  for c := '0' to '9' do
    begin
     Display;
     Enter;
     Optimize;
     Check;
    end;
  writeln('===========================');
  writeln(' Tong so diem : ', diem);
  readln;
end.
