{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt;

const
   tfi          =       'FSTR.INP';
   tfo          =       'FSTR.OUT';


var
   fi,fo        :       text;
   N            :       integer;
   m            :       integer;
   SA,SB,SR     :       string;
   fa,fb,fc,
   da,ca,db,cb,
   dc,cc        :       string;
   a,b,c        :       extended;

procedure Sinhdl;
var ch: char;
    i: integer;
begin
   clrscr;
   writeln('Ban co tao file ',tfi,' (C/K)?');
   repeat ch:=readkey until upcase(ch) in ['C','K'];
   if upcase(ch)='K' then exit;
   randomize;
   N:=random(30)+5;
   m:=random(10)+1;
   sa:='';
   for i:=1 to M do sa:=sa+chr(64+random(3)+1);
   m:=random(10)+1;
   sb:='';
   for i:=1 to M do sb:=sb+chr(64+random(3)+1);
   m:=random(15)+1;
   sr:=copy(sa+sb,1,m);
   assign(fi,tfi); rewrite(fi);
   writeln(fi,N);
   writeln(fi,sa);
   writeln(fi,sb);
   writeln(fi,sr);
   close(fi);
end;

procedure Docdl;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,N);
   readln(fi,SA);
   readln(fi,SB);
   readln(fi,SR);
   close(fi);
   m:=length(SR);
end;

function Dem(s1,s: string): extended;
var d: extended;
    k: integer;
begin
   d:=0;
   while pos(s1,s)>0 do
      begin
         k:=pos(s1,s);
         d:=d+1;
         delete(s,1,k);
      end;
   Dem:=d;
end;

function Chung: real;
begin
   fc:=ca+db;
   delete(fc,1,1);
   delete(fc,length(fc),1);
   Chung:=Dem(sr,fc);
end;

procedure Tinh;
var i: integer;
begin
   fa:=sa;
   fb:=sb;
   a:=Dem(sr,sa);
   b:=Dem(sr,sb);
   i:=2;
   while (i<=n) and (length(fa)<=m) do
      begin
         fc:=concat(fa,fb);
         c:=Dem(sr,fc);
         fa:=fb;
         fb:=fc;
         a:=b;
         b:=c;
         inc(i);
      end;
   if i<=n then
      begin
         da:=copy(fa,1,m);
         ca:=copy(fa,length(fa)-m+1,m);
         db:=copy(fb,1,m);
         cb:=copy(fb,length(fb)-m+1,m);
         while i<=n do
            begin
               c:=a+b+Chung;
               dc:=da; cc:=cb;
               a:=b;
               b:=c;
               da:=db; ca:=cb;
               db:=dc; cb:=cc;
               inc(i);
            end;
      end;
end;

procedure Inkq;
begin
   assign(fo,tfo); rewrite(fo);
   writeln(fo,c:0:0);
   close(fo);
end;

BEGIN
   {Sinhdl;}
   Docdl;
   Tinh;
   Inkq;
END.
