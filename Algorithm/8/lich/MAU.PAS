{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 65520,0,655360}
uses crt;

const
   tfi                  =       'LICH.INP';
   tfo                  =       'LICH.OUT';
   NN                   =       100;
   maxN                 =       100;

var
   fi,fo                :       text;
   N,M                  :       integer;
   L,C                  :       integer;
   a                    :       array[1..maxN] of integer;
   x                    :       array[0..maxN] of integer;
   d                    :       array[0..maxN,0..maxN] of LongInt;
   LP                   :       LongInt;

procedure Docdl;
var i: integer;
begin
   Readln(fi,N);
   readln(fi,L,C);
   for i:=1 to N do read(fi,a[i]);
end;

procedure TinhSoBuoi;
var i,j,t: integer;
begin
   fillchar(x,sizeof(x),0);
   x[0]:=0;
   for i:=1 to N do
      begin
         x[i]:=MaxInt;
         t:=0;
         for j:=i-1 downto 0 do
            begin
               t:=t+a[j+1];
               if t>L then break;
               if x[i]>x[j]+1 then x[i]:=x[j]+1;
            end;
      end;
   M:=x[N];
end;

function CP(t: Integer): LongInt;
var u: LongInt;
begin
   u:=t;
   if u=0 then CP:=0 else
      if u<=10 then CP:=-C else
         CP:=sqr(u-10);
end;

procedure TinhLangPhi;
var i,j,k,t: integer;
begin
   d[0,0]:=0;
   for j:=1 to M do d[0,j]:=d[0,j-1]+CP(l);
   for i:=1 to N do
      for j:=1 to M do
         begin
            t:=0;
            d[i,j]:=MaxLongInt;
            for k:=i-1 downto 0 do
               begin
                  t:=t+a[k+1];
                  if t>L then break;
                  if (d[k,j-1]<MaxLongInt) and (d[i,j]>d[k,j-1]+CP(L-t)) then
                     d[i,j]:=d[k,j-1]+CP(L-t);
               end;
         end;
   LP:=d[N,M];
end;

procedure Inkq;
begin
   writeln(fo,M);
   writeln(fo,LP);
end;

procedure SinhDL;
var ch: char;
    i: integer;
begin
   clrscr;
   write('Ban co tao file ',tfi,' (C/K)?');
   repeat ch:=readkey until upcase(ch) in ['C','K'];
   if upcase(ch)='K' then exit;
   randomize;
   N:=NN;
   L:=random(500)+1;
   C:=random(10)+1;
   for i:=1 to N do a[i]:=random(L)+1;
   assign(fi,tfi); rewrite(fi);
   writeln(fi,N);
   writeln(fi,L,' ',C);
   for i:=1 to N do write(fi,a[i],' ');
   close(fi);
end;

BEGIN
   {sinhDL;}
   assign(fi,tfi); reset(fi);
   assign(fo,tfo); rewrite(fo);
   Docdl;
   TinhSoBuoi;
   TinhLangPhi;
   Inkq;
   close(fi); close(fo);
END.