{$M 30000,0,655360}
uses crt;
const
     fi='ctt.in';
     bb='c.t';
     kl='k.l';
type
    link                =       ^node;
    node                =       record
      d                 :       integer;
      w                 :       integer;
      next              :       link;
    end;
var
   f,g:text;t:char;ten:string;
   c:array[1..1000] of link;
   diem:array['1'..'p'] of real;
   kk:array['1'..'p'] of longint;
   td:real;
   chua:array[1..1000] of byte;
   md:array[1..1000] of longint;
   n,m:integer;
   ts:longint;
   p:pointer;
procedure add(u,v,k:integer);
var
   l            :       link;
begin
new(l);
l^.d := v;l^.w := k;l^.next := c[u];
c[u] := l;
end;
procedure nhap;
var
   i,j,k:integer;
   l:link;
begin
assign(f,fi+t);reset(f);
readln(f,n);
for i:=1 to n do c[i]:=nil;
while not(seekeof(f)) do
      begin
      readln(f,i,j,k);
      add(i,j,k);add(j,i,k);
      end;
close(f);
m:=n div 2;
end;
procedure ijk(z:integer);
var
   l:link;
   last,i,j,dem:integer;
   ch:array[1..1000] of boolean;
   min:longint;
begin
for i:=1 to n do begin ch[i]:=true;md[i]:=1000000000;end;
md[z]:=0;last:=z;ch[z]:=false;
if chua[z]=z then dem:=1 else dem:=0;
while dem<m do
      begin
      l := c[last];
      while l <> nil do
            begin
            j := l^.d;
            if ch[j] and (md[j] > md[last] + l^.w) then
               begin
               md[j] := md[last] + l^.w;
               end;
            l := l^.next;
            end;
      min:=2000000000;
      for i:=1 to n do if ch[i] and (md[i]<min) then
          begin min:=md[i];last:=i;end;
      ch[last]:=false;
      if chua[last]=z then begin inc(dem);ts:=ts+md[last];end;
      end;
end;
procedure cham;
var
   x,y:integer;
begin
for x:=1 to n do chua[x]:=0;
ts:=0;
{$I-}assign(f,ten+'.ou'+t);reset(f);
if ioresult<>0 then
   begin
   writeln(g,'    Khong co file ket qua');
   exit;
   end;{$I+}
for x:=1 to m do
    begin
    read(f,y);
    if (y<1)or(y>n) then
       begin
       writeln(g,'    Ten thanh pho sai: ',y);
       close(f);exit;
       end;
    chua[y]:=1;
    end;
readln(f);
for x:=1 to m do
    begin
    read(f,y);
    if (y<1)or(y>n) then
       begin
       writeln(g,'    Ten thanh pho sai: ',y);
       close(f);exit;
       end;
    chua[y]:=2;
    end;
readln(f);
close(f);
for x:=1 to n do if chua[x]=0 then
    begin
    writeln(g,'    Thanh pho ',x,' chua co bao');
    exit;
    end;
ijk(1);ijk(2);
writeln(g,'    Tong so: ',ts);
diem[t]:=2*(kk[t]/ts);
if ts<kk[t] then kk[t]:=ts;
end;
BEGIN
clrscr;
writeln;
write('         CHAM BAI HS ');readln(ten);
assign(f,kl);reset(f);
for t:='1' to '5' do readln(f,kk[t]);
close(f);
assign(g,bb);append(g);
writeln(g,'            Bai HS ',ten);
for t:='1' to '5' do
    begin
    mark(p);
    writeln(g,'Test ',t);diem[t]:=0;
    nhap;cham;
    release(p);
    td:=td+diem[t];
    end;
writeln(g,'Tong so diem: ',td:0:2);
writeln(g,'     **********');
close(g);
assign(f,kl);rewrite(f);
for t:='1' to '5' do writeln(f,kk[t]);
close(f);
END.
