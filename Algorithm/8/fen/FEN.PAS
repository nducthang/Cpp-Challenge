{*********************************************************************
                            HANH TINH DAM LAY
*********************************************************************}
{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q-,R-,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
uses crt;

const
   tfi='FEN.INP';
   tfo='FEN.OUT';
   maxN=50;
   Qmax=maxN*maxN;
   GT: array[0..3,0..3] of byte=((0,3,2,1),
                                 (1,0,3,2),
                                 (2,1,0,3),
                                 (3,2,1,0));
   dh: array[1..5] of shortint=(0,-1,0,1,0);
   dc: array[1..5] of shortint=(1,0,-1,0,0);

type
   mang=array[1..60000] of byte;

var
   fi,fo: text;
   M,N: integer;
   a: array[1..maxN,1..maxN] of byte;
   q1f,q1l,q2f,q2l: integer;
   q1,q2: array[1..Qmax,1..2] of byte;
   Pre: byte;
   x: ^mang;
   TGMin: Word;

procedure Docdl;
var i,j: integer;
begin
   readln(fi,M,N);
   for i:=1 to M do
      begin
         for j:=1 to N do read(fi,a[i,j]);
         readln(fi);
      end;
end;

procedure InitQ1;
begin
   q1f:=1;
   q1l:=1;
end;

function Inside(i,j: byte): boolean;
begin
   Inside:=(i>=1) and (i<=M) and (j>=1) and (j<=N);
end;

procedure DuyetCR1(hkt,ckt: byte; var tr: byte; var Time: word);
var ok: boolean;
    dd: array[1..maxN,1..maxN] of byte;
    i,j,k,i1,j1: byte;
begin
   time:=0;
   q1f:=1; q1l:=1;
   q1[q1l,1]:=M; q1[q1l,2]:=1; inc(q1l); {PutQ1(M,1)}
   ok:=false;
   repeat
      q2f:=1; q2l:=1;{InitQ2}
      fillchar(dd,sizeof(dd),0);
      time:=time+1;
      while (q1f<>q1l) do
         begin
            i:=q1[q1f,1]; j:=q1[q1f,2]; inc(q1f);{GetQ1(i,j)}
            for k:=1 to 5 do
               begin
                  i1:=i+dh[k]; j1:=j+dc[k];
                  if inside(i1,j1) and (GT[a[i1,j1],Time mod 4]<>0) then
                     if dd[i1,j1]=0 then
                        begin
                           q2[q2l,1]:=i1; q2[q2l,2]:=j1;inc(q2l);{PutQ2(i1,j1)}
                           dd[i1,j1]:=1;
                           if (i1=hkt) and (j1=ckt) then
                              begin
                                 ok:=true;
                                 Tr:=k;
                                 exit;
                              end;
                        end;
               end;
         end;
      Q1:=Q2;
      q1f:=q2f;
      q1l:=q2l;
   until ok;
end;


procedure DuyetCR2(hkt,ckt: byte; Tg: word; var tr: byte);
var ok: boolean;
    dd: array[1..maxN,1..maxN] of byte;
    i,j,k,i1,j1: byte;
    Time: integer;
begin
   time:=0;
   q1f:=1; q1l:=1;
   q1[q1l,1]:=M; q1[q1l,2]:=1; inc(q1l); {PutQ1(M,1)}
   ok:=false;
   repeat
      q2f:=1; q2l:=1;{InitQ2}
      fillchar(dd,sizeof(dd),0);
      time:=time+1;
      while (q1f<>q1l) do
         begin
            i:=q1[q1f,1]; j:=q1[q1f,2]; inc(q1f);{GetQ1(i,j)}
            for k:=1 to 5 do
               begin
                  i1:=i+dh[k]; j1:=j+dc[k];
                  if inside(i1,j1) and (GT[a[i1,j1],Time mod 4]<>0) then
                     if dd[i1,j1]=0 then
                        begin
                           q2[q2l,1]:=i1; q2[q2l,2]:=j1;inc(q2l);{PutQ2(i1,j1)}
                           dd[i1,j1]:=1;
                           if (i1=hkt) and (j1=ckt) and (Time=Tg) then
                              begin
                                 ok:=true;
                                 Tr:=k;
                                 exit;
                              end;
                        end;
               end;
         end;
      Q1:=Q2;
      q1f:=q2f;
      q1l:=q2l;
   until ok;
end;

procedure TimNguoc;
var u,v: byte;
    i: word;
begin
   new(x);
   u:=1; v:=N;
   for i:=TgMin downto 1 do
     begin
        DuyetCR2(u,v,i,Pre);
        x^[i]:=Pre;
        u:=u-dh[Pre];
        v:=v-dc[Pre];
     end;
end;

procedure Inkq;
var i: word;
begin
   writeln(fo,TgMin);
   for i:=1 to TgMin do
      case x^[i] of
         1: write(fo,'E');
         2: write(fo,'N');
         3: write(fo,'W');
         4: write(fo,'S');
         5: write(fo,'P');
      end;
end;

BEGIN
   assign(fi,tfi); reset(fi);
   assign(fo,tfo); rewrite(fo);
   Docdl;
   DuyetCR1(1,N,Pre,TgMin);
   TimNguoc;
   Inkq;
   close(fi); close(fo);
END.