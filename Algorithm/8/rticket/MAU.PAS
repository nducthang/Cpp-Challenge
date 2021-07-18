{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 65520,0,655360}
uses crt;

const
   tfi='RTICKET.INP';
   tfo='RTICKET.OUT';
   NN =           10000;
   maxN=10000;

type
   mang=array[1..maxN] of LongInt;

var
   fi,fo: text;
   l1,l2,l3,c1,c2,c3: LongInt;
   N: integer;
   s,t: integer;
   d: mang;
   a: ^mang;

procedure Docdl;
var i: integer;
begin
   readln(fi,l1,l2,l3,c1,c2,c3);
   readln(fi,N);
   readln(fi,s,t);
   d[1]:=0;
   for i:=2 to N do readln(fi,d[i]);
end;

procedure XDB;
var i,j: integer;
    kc,gv: LongInt;
begin
   a^[s]:=0;
   if s<t then
      begin
         for i:=s+1 to t do
            begin
               a^[i]:=MaxLongInt;
               for j:=i-1 downto s do
                  begin
                     kc:=d[i]-d[j];
                     if kc>l3 then break;
                     if kc<=l1 then gv:=c1 else
                        if kc<=l2 then gv:=c2 else gv:=c3;
                     if (a^[j]<MaxLongInt) and (a^[i]>a^[j]+gv) then
                        a^[i]:=a^[j]+gv;
                  end;
            end;
      end
   else if s>t then
      begin
         for i:=s-1 downto t do
            begin
               a^[i]:=MaxLongInt;
               for j:=i+1 to s do
                  begin
                     kc:=d[j]-d[i];
                     if kc>l3 then break;
                     if kc<=l1 then gv:=c1 else
                        if kc<=l2 then gv:=c2 else gv:=c3;
                     if (a^[j]<MaxLongInt) and (a^[i]>a^[j]+gv) then
                        a^[i]:=a^[j]+gv;
                  end;
            end;
      end;
end;

procedure Inkq;
begin
   if a^[t]=MaxLongInt then writeln(fo,'NO') else
      writeln(fo,a^[t]);
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
   l1:=random(10000)+1;
   l2:=random(10000)+l1+1;
   l3:=random(10000)+l2+1;
   c1:=random(10000)+1;
   c2:=random(10000)+1+c1;
   c3:=random(10000)+1+c2;
   s:=random(n)+1;
   t:=random(n)+1;
   d[1]:=0;
   for i:=2 to N do d[i]:=d[i-1]+random(10000)+1;
   assign(fi,tfi); rewrite(fi);
   writeln(fi,l1,' ',l2,' ',l3,' ',c1,' ',c2,' ',c3);
   writeln(fi,N);
   writeln(fi,s,' ',t);
   for i:=2 to N do writeln(fi,d[i]);
   close(fi);
end;


BEGIN
   {sinhDL;}
   assign(fi,tfi); reset(fi);
   assign(fo,tfo); rewrite(fo);
   new(a);
   Docdl;
   XDB;
   Inkq;
   dispose(a);
   close(fi); close(fo);
END.