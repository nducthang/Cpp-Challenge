const
   tf='inp.10';

var
   f: text;
   k, s, i, n: integer;
   a: array[1..100] of integer;

begin
   randomize;
   n:=random(50)+50;
   n:=100;
   for i:=1 to n do a[i]:=random(100)+1;
   s:=0;
   for i:=1 to n do s:=s+a[i];
   k:=random(s)+1;
   assign(f,tf); rewrite(f);
   writeln(f,n,' ',k);
   for i:=1 to n do write(f,a[i],' ');
   close(f);
end.