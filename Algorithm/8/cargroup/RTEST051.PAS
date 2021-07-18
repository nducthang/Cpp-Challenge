var
 n, p, l, i,j  : integer;
 f : text;
 c :char;
begin
 randomize;
 for c := '0' to '9' do
  begin
   assign(f, 'cargroup.in'+c); rewrite(f);
   n := random(1000) + 1;
   writeLn(f, n, ' ', random(500) + 500, ' ', random(1000));
   for i := 1 to n do writeln(f, random(100) + 1, ' ', random(100) + 1);
   close(f);
  end;
end.