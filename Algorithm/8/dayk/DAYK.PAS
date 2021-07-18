{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}

const
   tfi                   =       'DAYK.INP';
   tfo                   =       'DAYK.OUT';
   maxN                  =       1001;
   maxK                  =       11;

var
   fi,fo                 :       text;
   N, K                  :       integer;
   a                     :       array[0..maxN] of integer;
   Tr                    :       array[0..maxN,0..maxK] of integer;
   b                     :       array[0..maxN,0..maxK] of integer;
   x,y                   :       array[1..maxN] of integer;
   slx,sly               :       integer;

procedure Docdl;
var i: integer;
begin
   assign(fi,tfi); reset(fi);
   read(fi,N, K);
   for i:=1 to N do read(fi,a[i]);
   close(fi);
   a[0]:=-maxint;
end;

procedure TinhDong0;
var i,l: integer;
begin
   b[0,0]:=0;
   Tr[0,0]:=-1;
   for i:=1 to N do
      begin
         b[i,0]:=maxint;
         tr[i,0]:=-1;
         for l:=i-1 downto 0 do
            if (a[l]<a[i]) and (b[l,0]+(i-l-1)<b[i,0]) then
               begin
                  b[i,0]:=b[l,0]+(i-l-1);
                  Tr[i,0]:=l;
               end;
      end;
end;

procedure XDB;
var i,j,l,ts: integer;
begin
   for i:=0 to N do
      for j:=0 to K do Tr[i,j]:=0;
   TinhDong0;
   for j:=1 to K do
      for i:=1 to N do
         begin
            b[i,j]:=maxint;
            Tr[i,j]:=-1;
            for l:=i-1 downto 1 do
               begin
                  Ts:=i-l-1; (* so phan tu nam giua k va i *)
                  if a[l]<a[i] then
                     begin
                        if (b[l,j]<maxint) and (b[l,j]+Ts<b[i,j]) then
                           begin
                              b[i,j]:=b[l,j]+Ts;
                              Tr[i,j]:=l;
                           end;
                     end
                  else
                     begin
                        if (b[l,j-1]<maxint) and (b[l,j-1]+Ts<b[i,j]) then
                           begin
                              b[i,j]:=b[l,j-1]+Ts;
                              Tr[i,j]:=l;
                           end;
                     end;
               end;
         end;
end;

procedure XLB;
var u,v,w,i,j: integer;
begin
   (* Tim vi tri cuoi cung cua day duoc giu lai *)
   u:=N;
   v:=K;
   for i:=1 to N do
      for j:=0 to K do
         if (b[i,j]<maxint) and (b[i,j]-i<b[u,v]-u) then
            begin
               u:=i;
               v:=j;
            end;
   sly:=0;
   slx:=0;
   repeat
      inc(slx);
      x[slx]:=u;
      w:=Tr[u,v];
      if a[w]<a[u] then u:=w else
         begin
            u:=w;
            v:=v-1;
            inc(sly);
            y[sly]:=u;
         end;
   until v=0;
   while u>0 do
      begin
         inc(slx);
         x[slx]:=u;
         u:=Tr[u,0];
      end;
end;

procedure Inkq;
var i: integer;
    dd: array[1..maxN] of byte;
begin
   for i:=1 to N do dd[i]:=1;
   for i:=1 to slx do dd[x[i]]:=0;
   assign(fo,tfo); rewrite(fo);
   writeln(fo,N-slx);
   for i:=1 to N do
      if dd[i]=1 then writeln(fo,i);
   writeln(fo,sly);
   for i:=1 to sly do writeln(fo,y[i]);
   close(fo);
end;

BEGIN
   Docdl;
   XDB;
   XLB;
   Inkq;
END.