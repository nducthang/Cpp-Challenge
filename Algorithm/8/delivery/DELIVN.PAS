{$M 32000,0,655360}
{$R+,S+,Q+}
uses crt;
const
    nn=1000;
    tt=1000;
    inpfile = 'DELIVERY.INP';
    outfile = 'DELIVERY.OUT';
var
    inp, out: text;
    n, kl, m, mn, t: integer;
    c, ik : array[0..nn*2] of integer;
    f1, f2: array[0..tt] of integer;

procedure qsort(l,r:integer);
var i,j,tg,mid:integer;
begin
   mid:=c[(l+r) div 2];
   i:=l;j:=r;
   while i<=j do
   begin
      while c[i]<mid do inc(i);
      while c[j]>mid do dec(j);
      if i<=j then
      begin
         tg:=c[i];c[i]:=c[j];c[j]:=tg;
         tg:=ik[i];ik[i]:=ik[j];ik[j]:=tg;
         inc(i);dec(j);
      end;
   end;
   if l<j then qsort(l,j);
   if i<r then qsort(i,r);
end;

procedure Chuanbi;
var i, tg:Integer;
begin
   assign(inp,inpfile);reset(inp);
   readln(inp,t);
   readln(inp,n);
   mn:=0;
   for i:=1 to n do
   begin
      read(inp, tg);
      inc(mn);
      c[mn]:= tg;
      ik[mn]:=1;
   end;
   readln(inp,m);
   for i:=1 to m do
   begin
      read(inp, tg);
      inc(mn);
      c[mn]:= tg;
      ik[mn]:=2;
   end;
   close(inp);

   qsort(1,mn);

end;

procedure Solve;
var i, j, jj, tg: integer;
    p: longint;
begin
   fillchar(f1,sizeof(f1),255);
   f1[0]:=0;
   f2:=f1;
   tg:=0; p:=0;
   for i:=1 to mn do
   begin
      p:= p+c[i];
      if ik[i]=1 then inc(tg,c[i]);
      if (tg>t*2)and(p>t*2) then break;
      for j:=0 to t do
         if (f1[j]<>-1) then
         begin
            if (p-j<=t)and(f2[j]<=f1[j]) then f2[j]:=f1[j]+1;
            jj:=j+c[i];
            if (ik[i]=1)and(jj<=t)and(f2[jj]<=f1[j]) then f2[jj]:=f1[j]+1;
         end;
      f1:=f2;
   end;
   kl:=0;
   for j:=0 to t do
      if f1[j]>kl then kl:=f1[j];
   assign(out,outfile);rewrite(out);
   writeln(out,kl);
   close(out);
end;

BEGIN
   Chuanbi;
   Solve;
END.
