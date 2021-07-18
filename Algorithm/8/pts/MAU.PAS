{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 65520,0,655360}
uses crt;

const
   tfi='PTS.INP';
   tfo='PTS.OUT';
   maxMN=100;
   NTO: array[1..25] of integer=( 2, 3, 5, 7,11,13,17,19,23,29,
                                 31,37,41,43,47,53,59,61,67,71,
                                 73,79,83,89,97);


var
   fi,fo: text;
   M,N,k: integer;
   a: array[1..100,1..100] of integer;
   x,y: array[0..100] of real;

procedure Docdl;
var i,j: integer;
begin
   readln(fi,M,N,k);
   for i:=1 to M do
      begin
         for j:=1 to N do read(fi,a[i,j]);
         readln(fi);
      end;
end;

procedure ChuanBi;
var i,j,l: integer;
begin
   for i:=0 to 100 do x[i]:=0; {khong xac dinh}
   for j:=0 to k do
      begin
         if j*NTO[1]>100 then break;
         x[j*NTO[1]]:=1;
      end;
   for l:=2 to 25 do
      begin
         y:=x;
         for i:=1 to 100 do
            begin
               x[i]:=0;
               for j:=0 to k do
                  begin
                     if i-j*NTO[l]<0 then break;
                     x[i]:=x[i]+y[i-j*NTO[l]];
                  end;
            end;
      end;
end;

procedure Inkq;
var i,j: integer;
begin
   for i:=1 to M do
      begin
         for j:=1 to N do write(fo,x[a[i,j]]:0:0,' ');
         writeln(fo);
      end;
end;

BEGIN
   assign(fi,tfi); reset(fi);
   assign(fo,tfo); rewrite(fo);
   Docdl;
   ChuanBi;
   Inkq;
   close(fi); close(fo);
END.