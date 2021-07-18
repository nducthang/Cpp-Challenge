{$r+}
const
   tfi='Express.inp';
   tfo='Express.out';
   maxN=201;

type
   mang1=array[1..maxN] of integer;

var
   fi, fo: text;
   s : array[1..maxN] of char;
   is: array[1..maxN] of char;
   N: integer;
   c: array[1..maxN] of ^mang1;
   t: array[1..maxN] of ^mang1;

procedure cp;
var i: integer;
begin
   for i:=1 to maxN do new(c[i]);
   for i:=1 to maxN do new(t[i]);
end;

procedure doc;
begin
   assign(fi,tfi); reset(fi);
   N:=0;
   while not seekeoln(fi) do
      begin
         inc(n);
         read(fi,s[n]);
      end;
   close(fi);
end;

function Cap(i,j: integer): boolean;
begin
   Cap:=((s[i]='(') and (s[j]=')')) or
        ((s[i]='[') and (s[j]=']')) or
        ((s[i]='{') and (s[j]='}'));
end;

procedure Tinh;
var i,j,k,l: integer;
begin
   for i:=1 to n do
      for j:=1 to n do c[i]^[j]:=0;
   for i:=1 to N do
      begin
         c[i]^[i]:=1;
         t[i]^[i]:=0;
      end;
   for k:=1 to n-1 do
     for i:=1 to n-k do
        begin
           j:=i+k;
           if Cap(i,j) then
              begin
                 c[i]^[j]:=c[i+1]^[j-1];
                 t[i]^[j]:=-1;
              end
           else
              begin
                 c[i]^[j]:=maxint; t[i]^[j]:=0;
                 for l:=i to j-1 do
                    if c[i]^[j]>c[i]^[l]+c[l+1]^[j] then
                       begin
                          c[i]^[j]:=c[i]^[l]+c[l+1]^[j];
                          t[i]^[j]:=l;
                       end;
              end;
        end;
end;

procedure Trace(k,l: integer);
var r: integer;
begin
   if k>l then exit;
   if k=l then
   begin
      case s[k] of
         '(': is[k]:=')';
         ')': is[k]:='(';
         '[': is[k]:=']';
         ']': is[k]:='[';
         '{': is[k]:='}';
         '}': is[k]:='{';
      end;
      exit;
   end;
   if Cap(k,l) then Trace(k+1,l-1) else
      begin
         r:=t[k]^[l];
         Trace(k,r);
         Trace(r+1,l);
      end;
end;

procedure tim;
var i: integer;
begin
   for i:=1 to N do is[i]:=#32;
   Trace(1,N);
end;

procedure viet;
var i: integer;
begin
   assign(fo,tfo); rewrite(fo);
   writeln(fo,c[1]^[n]);
   for i:=1 to n do
      if is[i]=#32 then write(fo,s[i]) else
         case is[i] of
            '(',')': write(fo,'()');
            '[',']': write(fo,'[]');
            '{','}': write(fo,'{}');
         end;
   close(fo);
end;

BEGIN
   cp;
   doc;
   tinh;
   tim;
   viet;
END.