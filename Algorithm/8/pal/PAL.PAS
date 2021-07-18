const
   tfi='Pal.inp';
   tfo='Pal.out';
   maxN=121;
   ONE='1';
   TWO='2';
   THREE='3';

type
   xau=string[maxN];
   BigNum=string[40];
   arr1=array[1..maxN] of BigNum;


var
   fi, fo: text;
   S: xau;
   N: integer;
   a,b,c: arr1;

procedure Cong(u,v: BigNum; var w: BigNum);
var nho, tong, nu, nv, nw, i: integer;
begin
   nu:=length(u);
   nv:=length(v);
   nw:=nu;
   if nw<nv then nw:=nv;
   for i:=nu+1 to nw do u:='0'+u;
   for i:=nv+1 to nw do v:='0'+v;
   w:='';
   for i:=1 to nw do w:=w+'0';
   nho:=0;
   for i:=nw downto 1 do
      begin
         tong:=ord(u[i])+ord(v[i])-96+nho;
         w[i]:=chr(tong mod 10+48);
         nho:=tong div 10;
      end;
   if nho>0 then w:='1'+w;
end;

procedure Tru(u,v: BigNum; var w: BigNum);
var i, nho, hieu, nu, nv, nw: integer;
begin
   nu:=length(u);
   nv:=length(v);
   nw:=nu;
   for i:=nv+1 to nw do v:='0'+v;
   w:='';
   for i:=1 to nw do w:=w+'0';
   nho:=0;
   for i:=nw downto 1 do
      begin
         hieu:=ord(u[i])-ord(v[i])-nho;
         if hieu<0 then
            begin
               hieu:=hieu+10;
               nho:=1;
            end
         else nho:=0;
         w[i]:=chr(hieu+48);
      end;
   while (length(w)>1) and (w[1]='0') do delete(w,1,1);
end;

procedure Doc;
begin
   readln(fi,s);
   N:=length(s);
end;

procedure Tinh;
var i,j,k: integer;
begin
   for i:=1 to N do b[i]:=ONE;
   for i:=1 to N-1 do
      if s[i]=s[i+1] then c[i]:=THREE else c[i]:=TWO;
   for k:=2 to n-1 do
      begin
         move(b,a,sizeof(b));
         move(c,b,sizeof(c));
         for i:=1 to N-k do
            begin
               j:=k+i;
               if s[i]=s[j] then
                  begin
                     {c[i]:=b[i]+b[i+1]+1}
                     Cong(b[i],b[i+1],c[i]);
                     Cong(c[i],ONE,c[i]);
                  end
               else
                  begin
                     {c[i]:=b[i]+b[i+1]-a[i+1];}
                     Cong(b[i],b[i+1],c[i]);
                     Tru(c[i],a[i+1],c[i]);
                  end;
            end;
      end;
end;

procedure Viet;
begin
   writeln(fo,c[1]);
end;

procedure Main;
begin
   assign(fi,tfi); reset(fi);
   assign(fo,tfo); rewrite(fo);
   doc;
   tinh;
   viet;
   close(fi); close(fo);
end;

BEGIN
   Main;
END.
