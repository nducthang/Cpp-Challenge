{*********************************************************************
*  Program  :     SUBSTRAC (Tru cho den khi con 1 so)                *
*  Date     :     11-02-2006                                         *
*  Group    :     Qui hoach dong                                     *
*********************************************************************}
const
   tfi                  =       'SUB.INP';
   tfo                  =       'SUB.OUT';
   maxN                 =       100;

type
   mang1                =       array[1..maxN] of integer;
   mang2                =       array[0..30000] of integer;
   mang3                =       array[1..maxN] of char;

var
   fi, fo: text;
   N,T,S: integer;
   a: mang1;
   good: boolean;
   dd: mang2;
   dau: mang3;


procedure Docdl;
var i: integer;
begin
   assign(fi,tfi); reset(fi);
   read(fi,N,T);
   for i:=1 to N do read(fi,a[i]);
   close(fi);
   S:=0;
   for i:=1 to N do s:=s+a[i];
end;

procedure Solve;
var u,max,i,j: integer;
label 0;
begin
   good:=false;
   if S+T-2*a[1]<0 then exit;
   if S+T-2*a[1]=0 then
      begin
         good:=true;
         goto 0;
      end;
   fillchar(dd,sizeof(dd),0);
   dd[0]:=N+1;
   max:=0;
   for i:=3 to N do
      begin
         j:=max;
         while j>=0 do
            begin
               if (dd[j]<>0) and (dd[j+2*a[i]]=0) then
                  begin
                     dd[j+2*a[i]]:=i;
                     if j+2*a[i]>max then max:=j+2*a[i];
                     if j+2*a[i]=S+T-2*a[1] then
                        begin
                           good:=true;
                           goto 0;
                        end;
                  end;
               dec(j);
            end;
      end;
   0:
   if not good then exit;
   dau[1]:='+'; dau[2]:='-'; dau[N]:='-';
   for i:=3 to N do dau[i]:='-';
   u:=S+T-2*a[1];
   while u>0 do
      begin
         dau[dd[u]]:='+';
         u:=u-2*a[dd[u]];
      end;
end;
procedure Inkq;
var i,j: integer;
begin
   assign(fo,tfo); rewrite(fo);
   if good then
      begin
         i:=3;
         while i<=N do
            begin
               while (i<=N) and (dau[i]='+') do
                  begin
                     writeln(fo,i-1);
                     for j:=i+1 to N do dau[j-1]:=dau[j];
                     dec(N);
                  end;
               inc(i);
            end;
         for i:=1 to N-1 do
            writeln(fo,1);
      end;
   close(fo);
end;


BEGIN
   Docdl;
   Solve;
   Inkq;
END.