{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
uses crt;

const       max        =250;
            test       ='5';
            fi         ='number.in'+test;
            fo         ='number.ou'+test;

var         l          :array[1..max+1,1..max+1]of byte;
            a,b,c      :string;

procedure docf;
var  f    :text;
 begin
    assign(f,fi);
    reset(f);
    readln(f,a);readln(f,b);
    close(f);
 end;

function maxso(x,y,z:byte):byte;
 begin
   if x<y then x:=y;
   if x<z then maxso:=z else maxso:=x;
 end;

procedure lam;
var i,j,k,x,y,m :integer;
    ch          :char;
 begin
   fillchar(l,sizeof(l),0);
   for i:=length(a) downto 1 do
    for j:=length(b) downto 1 do
     l[i,j]:=maxso(l[i+1,j],l[i,j+1],l[i+1,j+1]+ord(a[i]=b[j]));

   m:=0;c:='0';
   for ch:='9'downto '1' do
     begin
       i:=pos(ch,a);j:=pos(ch,b);
       if (i>0)and(j>0)and(l[i,j]>m) then begin c:=ch;m:=l[i,j];end;
     end;
   i:=pos(c,a)+1;j:=pos(c,b)+1;
   for k:=m-1 downto 1 do
     for ch:='9'downto '0' do
       begin
          x:=i;y:=j;
          while (x<=length(a))and(a[x]<>ch) do inc(x);
          while (y<=length(b))and(b[y]<>ch) do inc(y);
          if l[x,y]=k then
            begin
               c:=c+ch;i:=x+1;j:=y+1;
               break;
            end;
       end;
 end;

procedure check;
var f     :text;
    yr    :string;
 begin
    assign(f,fo);
    reset(f);
    read(f,yr);
    if yr<>c then
     begin
        textbackground(4);
        writeln('Ket qua sai!');
        textbackground(0);
        writeln('Ket qua cua ban:',yr);
        write('Dap so:',c);
     end
    else write('Ket qua dung!');

    close(f);
 end;

BEGIN
   clrscr;
   writeln('Input:',fi);
   writeln('Output:',fo);
   writeln;writeln;

   docf;
   lam;
   check;
   readln;
END.