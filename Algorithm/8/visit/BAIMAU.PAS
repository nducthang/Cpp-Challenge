{*********************************************************************
* Program     :      DUYET DIEM (Bai thay TUNG)                      *
* Date        :      04-11-2005                                      *
* Thuat toan  :      Qui hoach dong (1 chieu)                        *
*********************************************************************}

const
   tfi                  =     'VISIT.INP';
   tfo                  =     'VISIT.OUT';

var
   fi, fo               :     text;
   N                    :     longint;
   T,P,l,r,lc,rc,Tc,Pc  : longint;

function min(u,v: longint): longint;
begin
   if u<v then min:=u else min:=v;
end;

procedure solve;
var i: longint;
begin
   readln(fi,N);
   readln(fi,l,r);
   T:=(r-1)+(r-l);
   P:=r-1;
   for i:=2 to n do
      begin
         lc:=l; rc:=r;
         Tc:=T; Pc:=p;
         readln(fi,l,r);
         T:=min(Tc+abs(r-lc)+(r-l)+1,Pc+abs(r-rc)+(r-l)+1);
         P:=min(Tc+abs(l-lc)+(r-l)+1,Pc+abs(l-rc)+(r-l)+1);
      end;
   writeln(fo,min(T+(N-l),P+(N-r)));
end;

BEGIN
   assign(fi,tfi); reset(fi);
   assign(fo,tfo); rewrite(fo);
   solve;
   close(fi); close(fo);
END.