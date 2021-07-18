{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q-,R-,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}

const
   tfi            =     'SuaTuoi.INP';
   tfo            =     'SuaTuoi.OUT';
   maxN           =     100;
   maxL           =     1000;

var
   fi,fo          :     text;
   N,M,L          :     integer;
   a              :     array[1..maxN] of integer;
   Tr             :     array[0..maxL] of integer;
   ok             :     integer;
   Trai, Phai     :     integer;

   count          :     integer;
   x              :     array[1..2,1..4*maxN] of integer;

   slT, slP       :     integer;
   T, P           :     array[1..maxN] of integer;

   B              :     array[1..maxN] of integer;
   dd             :     array[1..maxN] of integer;

procedure Docdl;
var i: integer;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,N,M);
   for i:=1 to N do read(fi,a[i]);
   L:=a[1];
   close(fi);
end;

procedure DanhDau;
var i, j, max: integer;
begin
   for i:=0 to L do Tr[i]:=0;
   Tr[0]:=-1;
   max:=0;
   for i:=1 to N do
      begin
         j:=max;
         while j>=0 do
            begin
               if Tr[j]<>0 then
                  begin
                     if (j+a[i]<=L) and (Tr[j+a[i]]=0) then
                        begin
                           Tr[j+a[i]]:=i;
                           if j+a[i]>max then max:=j+a[i];
                        end;
                  end;
               dec(j);
            end;
      end;
end;

procedure Tim;
var k: integer;
begin
   ok:=0;
   for k:=0 to L do
      if Tr[k]<>0 then
         begin
            if (k+M<=L) and (Tr[k+M]<>0) then
               begin
                  ok:=1;
                  Trai:=k+M;
                  Phai:=k;
                  exit;
               end;
            if (k<=M) and (Tr[k+L-M]<>0) then
               begin
                  ok:=2;
                  Trai:=k+L-M;
                  Phai:=k;
               end;
         end;
end;

procedure TimChai;
var v: integer;
begin
   slT:=0;
   v:=Trai;
   while v>0 do
      begin
         inc(slT);
         T[slT]:=Tr[v];
         v:=v-a[Tr[v]];
      end;
   slP:=0;
   v:=Phai;
   while v>0 do
      begin
         inc(slP);
         P[slP]:=Tr[v];
         v:=v-a[Tr[v]];
      end;
end;

procedure Rot;
var i, k: integer;
begin
   (* do tu binh 1 vao day cac binh ben trai *)
   for i:=1 to N do B[i]:=0;
   B[1]:=L;
   for i:=1 to slT do
      if T[i]<>1 then
        begin
           inc(count);
           x[1,count]:=1;
           x[2,count]:=T[i];
           B[1]:=B[1]-a[T[i]];
           B[T[i]]:=a[T[i]];
        end;
   (* do cac binh ben trao vao day cac binh ben phai *)
   k:=1;
   for i:=1 to slP do
      begin
         while B[P[i]]<a[P[i]] do
            begin
               if B[T[k]]<a[P[i]]-B[P[i]] then
                  begin
                     inc(count);
                     x[1,count]:=T[k];
                     x[2,count]:=P[i];
                     B[P[i]]:=B[P[i]]+B[T[k]];
                     B[T[k]]:=0;
                     inc(k);
                  end
               else
                  begin
                     inc(count);
                     x[1,count]:=T[k];
                     x[2,count]:=P[i];
                     B[T[k]]:=B[T[k]]-(a[P[i]]-B[P[i]]);
                     if B[T[k]]=0 then inc(k);
                     B[P[i]]:=a[P[i]];
                  end;
            end;
      end;
   (* danh dau cac binh ben trai *)
   for i:=1 to N do dd[i]:=0;
   for i:=1 to slT do dd[T[i]]:=1;
end;

procedure RotM;
var i: integer;
begin
   Count:=0;
   TimChai;
   Rot;
   (* do tat ca cac chai ben trai ra binh *)
   for i:=1 to N do
      if (dd[i]=1) and (b[i]>0) then
         begin
             inc(count);
             x[1,count]:=i;
             x[2,count]:=0;
         end;
end;

procedure RotLM;
var i: integer;
begin
   count:=0;
   TimChai;
   Rot;
   (* do tat ca cac chai khong o ben trai ra binh *)
   for i:=1 to N do
      if (dd[i]=0) and (b[i]>0) then
         begin
            inc(count);
            x[1,count]:=i;
            x[2,count]:=0;
         end;
end;

procedure Inkq;
var i: integer;
begin
   assign(fo,tfo); rewrite(fo);
   if ok=0 then writeln(fo,-1) else
      begin
         writeln(fo,count);
         for i:=1 to count do writeln(fo,x[1,i],' ',x[2,i]);
      end;
   close(fo);
end;

BEGIN
   Docdl;
   DanhDau;
   Tim;
   if ok=1 then RotM else RotLM;
   Inkq;
END.