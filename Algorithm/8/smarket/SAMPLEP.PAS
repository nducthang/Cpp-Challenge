{*************************************************************************
Program    :   SIEU THi MAY MAN (Baif 2 thi HSG Quoc gia 2007)
Date       :   20-3-2007
Group      :   Qui hoach dong
Langues    :   Free Pascal
*************************************************************************}
const
   tfi='SMARKET.INP';
   tfo='SMARKET.OUT';
   MAXN=501;
   MAXS=10001;

var
   fi, fo: text;
   s,n: integer;
   x,c,m: array[1..MAXN] of longint;
   f: array[0..MAXS,0..MAXN] of longint;
   d: array[0..MAXS] of longint;
   sl: array[0..MAXS] of longint;

procedure doc;
var i: integer;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,s,n);
   for i:=1 to n do readln(fi,c[i],m[i]);
   close(fi);
end;

procedure Tinh;
var k,i,l: integer;
begin
   for k:=0 to S do f[k,0]:=0; f[0,0]:=1;
   for i:=1 to n do
      for k:=0 to S do
         begin
            f[k,i]:=f[k,i-1];
            for l:=1 to m[i] do
               begin
                  if k-l*c[i]<0 then break;
                  f[k,i]:=(f[k,i]+f[k-l*c[i],i-1]) mod 131131;
               end;
         end;
end;

procedure viet;
var i: integer;
begin
   assign(fo,tfo); rewrite(fo);
   writeln(fo,f[s,n]);
   if f[s,n]<>0 then
      for i:=1 to n do write(fo,x[i],' '); writeln(fo);
   close(fo);
end;

procedure Tim;
var u,max,i,j,l: integer;
label l1;
begin
   if f[s,n]=0 then exit;
   fillchar(d,sizeof(d),0);
   d[0]:=-1;
   max:=0;
   for i:=1 to n do
      for j:=max downto 0 do
         if d[j]<>0 then
            begin
               for l:=1 to m[i] do
                  begin
                     if j+l*c[i]>s then break;
                     if d[j+l*c[i]]=0 then
                        begin
                           d[j+l*c[i]]:=i;
                           sl[j+l*c[i]]:=l;
                           if max<j+l*c[i] then max:=j+l*c[i];
                           if max=s then goto l1;
                        end;
                  end;
            end;
   l1:
   for i:=1 to n do x[i]:=0;
   u:=s;
   while u>0 do
      begin
         i:=d[u];
         x[i]:=sl[u];
         u:=u-x[i]*c[i];
      end;
end;

BEGIN
   doc;
   tinh;
   tim;
   viet;
END.
