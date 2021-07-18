const
   tfi                     =    'FALL.INP';
   tfo                     =    'FALL.OUT';
   maxN                    =    1002;
   VC                      =    maxlongint;

type
   van                     =    record
                                   x1, x2, H: longint;
                                   id: longint;
                                end;

var
   fi, fo                  :    text;
   N                       :    longint;
   x,y,delta               :    longint;
   a                       :    array[0..maxN] of van;
   i0                      :    longint;

   F                       :    array[1..2,0..maxN] of longint;
   Tr                      :    array[1..2,0..maxN] of longint;

   Min                     :    longint;
   sl                      :    longint;
   kq                      :    array[1..maxN] of longint;

procedure Docdl;
var i: longint;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,N,x,y,delta);
   for i:=1 to N do
      with a[i] do
         readln(fi,x1,x2,H);
   close(fi);
end;

procedure Trao(var u,v: van);
var w: van;
begin
   w:=u;
   u:=v;
   v:=w;
end;

procedure SapXep;
var i,j: longint;
begin
   for i:=1 to N-1 do
      for j:=i+1 to N do
         if a[i].H<a[j].H then
            Trao(a[i],a[j]);
end;

procedure Qsort(k,l: longint);
var r,i,j: longint;
begin
   r:=(k+l) div 2;
   i:=k;
   j:=l;
   repeat
      while a[i].H>a[r].H do inc(i);
      while a[j].H<a[r].H do dec(j);
      if i<=j then
         begin
            Trao(a[i],a[j]);
            inc(i); dec(j);
         end;
   until i>j;
   if k<j then Qsort(k,j);
   if i<l then Qsort(i,l);
end;

procedure Ke(i1,k1,i2,k2: longint; var ok: boolean; var d: longint);
var xx,yy,i: longint;
begin
   ok:=false;
   if a[i1].H-a[i2].H>delta then exit;
   if k1=1 then xx:=a[i1].x1 else xx:=a[i1].x2;
   yy:=a[i1].H;
   if (xx<a[i2].x1) or (xx>a[i2].x2) then exit;

   for i:=i1+1 to i2-1 do
      if (a[i].x1<=xx) and (xx<=a[i].x2) then exit;

   ok:=true;
   if k2=1 then d:=xx-a[i2].x1+yy-a[i2].H
           else d:=a[i2].x2-xx+yy-a[i2].H;
end;

function RoiDuoc(k,i: longint): boolean;
var j, xx, yy: longint;
begin
   RoiDuoc:=false;
   if k=1 then xx:=a[i].x1 else xx:=a[i].x2;
   yy:=a[i].H;
   for j:=i+1 to N do
      if (a[j].x1<=xx) and (xx<=a[j].x2) then exit;
   RoiDuoc:=true;
end;

procedure TimNguoc;
var i,k,ktk,kti: longint;
begin
   (* Tim diem ket thuc *)
   Min:=VC;
   for i:=N downto i0 do
      if (a[i].H<=delta) then
         for k:=1 to 2 do
            if (F[k,i]<VC) and RoiDuoc(k,i) and (F[k,i]+a[i].H<Min) then
               begin
                  Min:=F[k,i]+a[i].H;
                  ktk:=k;
                  kti:=i;
               end;
   if min=VC then exit;
   i:=kti;
   k:=ktk;
   sl:=0;
   repeat
      inc(sl);
      if k=1 then kq[sl]:=a[i].id else kq[sl]:=-a[i].id;
      i:=Tr[k,i];
      if i<0 then
         begin
            i:=-i;
            k:=2;
         end
      else if i<maxN then k:=1;
   until i=maxN;
end;

procedure Solve;
var i,k,j,l: longint;
    ok: boolean;
    d: longint;
begin
   for i:=1 to N do a[i].id:=i;
   SapXep;
   {Qsort(1,N);}
   i0:=1;
   while (i0<N) and (a[i0].H>y) do inc(i0);
   dec(i0);
   with a[i0] do
      begin
         x1:=x;
         x2:=x;
         H:=y;
      end;
   F[1,i0]:=0; Tr[1,i0]:=maxN;
   F[2,i0]:=0; Tr[2,i0]:=maxN;
   for i:=i0+1 to N do
      for k:=1 to 2 do
         begin
            F[k,i]:=VC;
            for j:=i-1 downto i0 do
               for l:=1 to 2 do
                  if F[l,j]<VC then
                     begin
                        Ke(j,l,i,k,ok,d);
                        if ok and (F[k,i]>F[l,j]+d) then
                           begin
                              F[k,i]:=F[l,j]+d;
                              case l of
                                 1: Tr[k,i]:=j;
                                 2: Tr[k,i]:=-j;
                              end;
                           end;
                     end;
         end;
   TimNguoc;
end;

procedure Inkq;
var i: longint;
begin
   assign(fo,tfo); rewrite(fo);
   if Min=VC then writeln(fo,-1) else
      begin
         writeln(fo,Min);
         for i:=sl-1 downto 1 do
            if kq[i]>0 then writeln(fo,kq[i],' ',0)
                       else writeln(fo,-kq[i],' ',1);
      end;
   close(fo);
end;


BEGIN
   Docdl;
   Solve;
   Inkq;
END.