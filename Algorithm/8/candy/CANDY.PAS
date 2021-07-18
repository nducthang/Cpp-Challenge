{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

const
   tfi='CANDY.INP';
   tfo='CANDY.OUT';
   maxN=1000;

var
   fi,fo: text;
   N: longint;
   a: array[1..maxN] of longint;
   S: array[1..2] of longint;
   x: array[1..maxN] of longint;
   Delta: longint;

procedure Docdl;
begin
   assign(fi,tfi); reset(fi);
   N:=0;
   while not seekeof(fi) do
      begin
         inc(N);
         read(fi,a[N]);
      end;
   close(fi);
end;

procedure KhoiDau;
var i: longint;
begin
   S[1]:=0;
   for i:=1 to N do
      begin
         x[i]:=1;
         S[1]:=S[1]+a[i];
      end;
   S[2]:=0;
   Delta:=S[1];
end;

function Tim(i: longint): longint;
var k: longint;
begin
   for k:=1 to N do
      if (x[k]=i) then
         if Delta>abs(S[i]-S[3-i]-2*a[k]) then
            begin
               Tim:=k;
               exit;
            end;
   Tim:=0;
end;

procedure Chuyen(i,k: longint);
begin
   Delta:=abs(S[i]-S[3-i]-2*a[k]);
   x[k]:=3-i;
   S[i]:=S[i]-a[k];
   S[3-i]:=S[3-i]+a[k];
end;

procedure TinhDoi(var u,v: longint; var ok: boolean);
var i,j: longint;
begin
   ok:=true;
   for i:=1 to N do
      if x[i]=1 then
         for j:=1 to N do
            if x[j]=2 then
               if Delta>abs(S[1]-S[2]-2*(a[i]-a[j])) then
                  begin
                     u:=i;
                     v:=j;
                     exit;
                  end;
   ok:=false;
end;

procedure Chia;
var ok,stop: boolean;
    i,j,k: longint;
begin
   KhoiDau;
   stop:=false;
   while not stop do
      begin
         stop:=true;
         for i:=1 to 2 do
            begin
               k:=Tim(i);
               if k>0 then
                  begin
                     Chuyen(i,k);
                     Stop:=false;
                     break;
                  end;
            end;
         if stop then
            begin
               TinhDoi(i,j,ok);
               if ok then
                  begin
                     Chuyen(1,i);
                     Chuyen(2,j);
                     stop:=false;
                  end;
            end;
      end;
end;

procedure Inkq;
var i: longint;
begin
   assign(fo,tfo); rewrite(fo);
   writeln(fo,S[1],' ',S[2],' ',Delta);
   for i:=1 to N do
      if x[i]=1 then write(fo,i,' ');
   writeln(fo);
   for i:=1 to N do
      if x[i]=2 then write(fo,i,' ');
   close(fo);
end;


BEGIN
   Docdl;
   Chia;
   Inkq;
END.