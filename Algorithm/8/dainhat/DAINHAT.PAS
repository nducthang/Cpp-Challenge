{*********************************************************************
                        DOAN DAU DAI NHAT
*********************************************************************}
uses crt;

const
   tfi1                         =        'INPUT.TXT';
   tfi2                         =         'DATA.TXT';
   tfo                          =       'OUTPUT.TXT';
   maxN                         =       100;
   maxL                         =       20;


var
   N                            :       integer;
   p                            :       array[1..maxN] of string[maxL];

   MaxLen                       :       LongInt;

   Buff                         :       string[2*maxL];
   cB                           :       integer;

   fi,fo                        :       text;
   dd                           :       array[0..2*maxL] of 0..1;

procedure ChuanBi;
var f: text;
    i,j,L: integer;
    c: char;
begin
   assign(f,tfi1); reset(f);
   readln(f,N);
   for i:=1 to N do
      begin
         readln(f,L);
         p[i]:='';
         for j:=1 to L do
            begin
               read(f,c);
               p[i]:=p[i]+c;
            end;
         readln(f);
      end;
   close(f);
end;

procedure DocVDem;
var c: char;
    i: integer;
begin
   if length(Buff)>maxL then
      begin
         delete(Buff,1,maxL);
         for i:=maxL to cb do dd[i-maxL]:=dd[i];
         cb:=cb-maxL;
         MaxLen:=MaxLen+maxL;
      end;
   while (not seekeof(fi)) and (length(Buff)<2*maxL) do
      begin
         readln(fi,c);
         Buff:=Buff+c;
      end;
   for i:=cb+1 to length(Buff) do dd[i]:=0;
end;

procedure Xuli;
var i,j,maxCB: integer;
    s: string[2*maxL];
begin
   dd[cB]:=1;
   for i:=0 to Length(Buff) do
      if dd[i]=1 then
         begin
            maxCB:=i;
            s:=copy(Buff,i+1,255);
            for j:=1 to N do
               if pos(p[j],s)=1 then dd[i+length(p[j])]:=1;
         end;
   cB:=maxCB;
end;

BEGIN
   ChuanBi;
   assign(fi,tfi2); reset(fi);
   assign(fo,tfo); rewrite(fo);
   MaxLen:=0;
   Buff:='';
   cB:=0;
   while not seekeof(fi) do
      begin
         DocVDem;
         Xuli;
         if cB<maxL then break;
      end;
   MaxLen:=MaxLen+cB;
   writeln(fo,MaxLen);
   close(fi); close(fo);
END.