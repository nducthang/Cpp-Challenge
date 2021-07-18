uses crt;
const
        inpf                    =       'ctt.in';
        outf                    =       'ctt.ou';
        maxn                    =       1000;
        vc                      =       1000000000;
type
        link                    =       ^node;
        node                    =       record
                                          v,cp:integer;
                                          next:link;
                                        end;
var
        fi,fo                   :       text;
        n,m,hs                  :       longint;
        c                       :       array[1..maxn]of link;
        min,mtg,gt              :       array[1..maxn]of longint;
        tt,h,vt                 :       array[1..maxn]of integer;
        t                       :       char;

procedure mofile;
begin
  assign(fi,inpf+t);
  reset(fi);
  assign(fo,outf+t);
  rewrite(fo);
end;
(*תתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתת*)
procedure dongfile;
begin
  close(fi);
  close(fo);
end;
(*תתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתת*)
procedure nhap;
var aa,bb,cc,i:integer;
    p:link;
begin
  readln(fi,n,m);
  fillchar(c,sizeof(c),0);
  for i:=1 to m do
  begin
    readln(fi,aa,bb,cc);
    new(p);
    p^.v:=bb;
    p^.cp:=cc;
    p^.next:=c[aa];
    c[aa]:=p;
    new(p);
    p^.v:=aa;
    p^.cp:=cc;
    p^.next:=c[bb];
    c[bb]:=p;
  end;
end;
(*תתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתת*)
procedure cb;
begin
end;
(*תתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתת*)
procedure upheap(i:integer);
var tt1,j:integer;
    gtss:longint;
begin
  tt1:=h[i];
  gtss:=min[tt1];
  while i>1 do
  begin
    j:=i shr 1;
    if min[h[j]] > gtss then
    begin
      h[i]:=h[j];
      vt[h[i]]:=i;
    end else break;
    i:=j;
  end;
  h[i]:=tt1;
  vt[tt1]:=i;
end;
(*תתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתת*)
procedure downheap(i:integer);
var tt1,j:integer;
    gtss:longint;
begin
  tt1:=h[i];
  gtss:=min[tt1];
  while i<=hs shr 1 do
  begin
    j:=i shl 1;
    if (j<hs)and(min[h[j]] > min[h[j+1]]) then inc(j);
    if min[h[j]] < gtss then
    begin
      h[i]:=h[j];
      vt[h[i]]:=i;
    end else break;
    i:=j;
  end;
  h[i]:=tt1;
  vt[tt1]:=i;
end;
(*תתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתת*)
procedure lay(var i:integer);
begin
  i:=h[1];
  h[1]:=h[hs];
  vt[h[1]]:=1;
  dec(hs);
  if hs>1 then downheap(1);
end;
(*תתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתת*)
procedure tinh(aaa:integer);
var i,j,v1:integer;
    gtmin,cost:longint;
    p:link;
begin
  for i:=1 to n do h[i]:=i;
  h[aaa]:=1;
  h[1]:=aaa;
  for i:=1 to n do vt[h[i]]:=i;
  hs:=n;
  for i:=1 to n do
  begin
    lay(j);
    gtmin:=min[j];
    p:=c[j];
    while p<>nil do
    begin
      v1:=p^.v;
      cost:=gtmin+p^.cp;
      if min[v1] > cost then
      begin
        min[v1]:=cost;
        upheap(vt[v1]);
      end;
      p:=p^.next;
    end;
  end;
end;
(*תתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתת*)
procedure sort(l,r:integer);
var i,j:integer;
    tg1,tg2:longint;
begin
  i:=l;
  j:=r;
  tg1:=gt[tt[l+random(r-l+1)]];
  repeat
    while gt[tt[i]] < tg1 do inc(i);
    while tg1 < gt[tt[j]] do dec(j);
    if i<=j then
    begin
      tg2:=tt[i];tt[i]:=tt[j];tt[j]:=tg2;
      inc(i);
      dec(j);
    end;
  until i>j;
  if i<r then sort(i,r);
  if l<j then sort(l,j);
end;
(*תתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתת*)
procedure xuli;
var i:integer;
    tg:longint;
begin
  for i:=1 to n do min[i]:=vc;
  min[1]:=0;
  tinh(1);
  mtg:=min;
  for i:=1 to n do min[i]:=vc;
  min[2]:=0;
  tinh(2);
  for i:=1 to n do
  begin
    tt[i]:=i;
    gt[i]:=mtg[i]-min[i];
  end;
  sort(1,n);
  for i:=1 to n div 2 do write(fo,tt[i],' ');
  writeln(fo);
  for i:=n div 2 + 1 to n do write(fo,tt[i],' ');
  tg:=0;
  for i:=1 to n div 2 do tg:=tg+mtg[tt[i]];
  for i:=n div 2 + 1 to n do tg:=tg+min[tt[i]];
{  writeln(tg);}
end;
(*תתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתת*)
procedure xuat;
begin
end;
(*תתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתתת*)
begin
for t:='1' to '5' do
begin
  mofile;
  nhap;
  cb;
  xuli;
  xuat;
  dongfile;
end;
end.