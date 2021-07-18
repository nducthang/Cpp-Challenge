const
   tfi                     =     'STEDIT.INP';
   tfo                     =     'STEDIT.OUT';
   maxN                    =     255;

type
   mang                    =     array[0..maxN] of byte;
   PBD                     =     record
                                    id: byte;
                                    Vt1,Vt2: byte;
                                    Kytu: char;
                                 end;

var
   fi, fo                  :     text;
   s1, s2                  :     string;
   n,m                     :     integer;
   F                       :     array[0..maxN] of ^mang;
   Tr                      :     array[0..maxN] of ^mang;
   x                       :     array[0..2*maxN] of PBD;
   slx                     :     integer;

procedure Docdl;
begin
   assign(fi,tfi); reset(fi);
   readln(fi,S1);
   n:=length(s1);
   readln(fi,s2);
   m:=length(s2);
   close(fi);
end;

procedure Tinh;
var t,i,j: integer;
begin
   F[0]^[0]:=0;
   for i:=1 to N do
      begin
         F[i]^[0]:=i;
         Tr[i]^[0]:=4;
      end;
   for j:=1 to M do
      begin
         F[0]^[j]:=j;
         Tr[0]^[j]:=3;
      end;
   for i:=1 to N do
      for j:=1 to M do
         if s1[i]=s2[j] then
            begin
               F[i]^[j]:=F[i-1]^[j-1];
               Tr[i]^[j]:=0; {giu nguyen}
               if F[i]^[j]>F[i-1]^[j]+1 then
                  begin
                     F[i]^[j]:=F[i-1]^[j]+1;
                     Tr[i]^[j]:=4; {phep xoa}
                  end;
               if F[i]^[j]>F[i]^[j-1]+1 then
                  begin
                     F[i]^[j]:=F[i]^[j-1]+1;
                     Tr[i]^[j]:=3; {phep chen}
                  end;
            end
         else
            begin
               F[i]^[j]:=F[i-1]^[j-1]+1;
               Tr[i]^[j]:=1; {doi ky tu}
               if F[i]^[j]>F[i-1]^[j]+1 then
                  begin
                     F[i]^[j]:=F[i-1]^[j]+1;
                     Tr[i]^[j]:=4; {phpe xoa}
                  end;
               if F[i]^[j]>F[i]^[j-1]+1 then
                  begin
                     F[i]^[j]:=F[i]^[j-1]+1;
                     Tr[i]^[j]:=3; {phep chen}
                  end;
               if (i>1) and (j>1) then
                  begin
                     if s1[i-1]=s2[j] then
                        begin
                           if s1[i]=s2[j-1] then
                              begin
                                 if F[i]^[j]>F[i-2]^[j-2]+1 then
                                   begin
                                      F[i]^[j]:=F[i-2]^[j-2]+1;
                                      Tr[i]^[j]:=5; {Doi day S1}
                                   end;
                              end
                           else
                              begin
                                 t:=j-2;
                                 while (t>0) and (s2[t]<>s1[i]) do dec(t);
                                 if (t>0) and (F[i]^[j]>F[i-2]^[t-1]+j-t) then
                                    begin
                                       F[i]^[j]:=F[i-2]^[t-1]+j-t;
                                       Tr[i]^[j]:=5; {Doi day S1}
                                    end;
                              end;
                        end;
                     if s2[j-1]=s1[i] then
                        begin
                           if s2[j]=s1[i-1] then
                              begin
                                 if F[i]^[j]>F[i-2]^[j-2]+1 then
                                    begin
                                       F[i]^[j]:=F[i-2]^[j-2]+1;
                                       Tr[i]^[j]:=6; {Doi day S2}
                                    end;
                              end
                           else
                              begin
                                 t:=i-2;
                                 while (t>0) and (s1[t]<>s2[j]) do dec(t);
                                 if (t>0) and (F[i]^[j]>F[t-1]^[j-2]+i-t) then
                                    begin
                                       F[i]^[j]:=F[t-1]^[j-2]+i-t;
                                       Tr[i]^[j]:=6; {Doi day S2}
                                    end;
                              end;
                        end;
                  end;
            end;
end;

procedure Tim;
var u,v,t,i: integer;
begin
   u:=N;
   v:=M;
   slx:=0;
   while (u>0) or (v>0) do
      begin
         case Tr[u]^[v] of
            0: begin
                  u:=u-1;
                  v:=v-1;
               end;
            1: begin
                  inc(slx);
                  with x[slx] do
                     begin
                        id:=1;
                        vt1:=v;
                        Kytu:=S2[v];
                     end;
                  u:=u-1;
                  v:=v-1;
               end;
            3: begin
                  inc(slx);
                  with x[slx] do
                     begin
                        id:=3;
                        vt1:=v-1;
                        Kytu:=S2[v];
                     end;
                  v:=v-1;
               end;
            4: begin
                  inc(slx);
                  with x[slx] do
                     begin
                        id:=4;
                        vt1:=v+1;
                     end;
                  u:=u-1;
               end;
            5: begin
                  if s1[u]=s2[v-1] then
                     begin
                        inc(slx);
                        with x[slx] do
                           begin
                              id:=2;
                              vt1:=v-1;
                              vt2:=v;
                           end;
                        u:=u-2;
                        v:=v-2;
                     end
                  else
                     begin
                        t:=v-2;
                        while (s2[t]<>s1[u]) do dec(t);
                        for i:=1 to v-t-1 do
                           begin
                              inc(slx);
                              with x[slx] do
                                 begin
                                    id:=3;
                                    vt1:=t;
                                    kytu:=S2[t+i];
                                 end;
                           end;
                        inc(slx);
                        with x[slx] do
                           begin
                              id:=2;
                              vt1:=t;
                              vt2:=t+1;
                           end;
                        u:=u-2;
                        v:=t-1;
                     end;
               end;
            6: begin
                  if s2[v]=s1[u-1] then
                     begin
                        inc(slx);
                        with x[slx] do
                           begin
                              id:=2;
                              vt1:=v-1;
                              vt2:=v;
                           end;
                        u:=u-2;
                        v:=v-2;
                     end
                  else
                     begin
                        inc(slx);
                        with x[slx] do
                           begin
                              id:=2;
                              vt1:=v-1;
                              vt2:=v;
                           end;
                        t:=u-2;
                        while (t>0) and (s1[t]<>s2[v]) do dec(t);
                        for i:=1 to u-t-1 do
                           begin
                              inc(slx);
                              with x[slx] do
                                 begin
                                    id:=4;
                                    vt1:=v;
                                 end;
                           end;
                        u:=t-1;
                        v:=v-2;
                     end;
               end;
         end;
      end;
end;

procedure inkq;
var i: integer;
begin
   assign(fo,tfo); rewrite(fo);
   writeln(fo,F[N]^[M]);
   for i:=slx downto 1 do
      with x[i] do
         begin
            write(fo,id,' ');
            case id of
               1: writeln(fo,vt1,' ',kytu);
               2: writeln(fo,vt1,' ',vt2);
               3: writeln(fo,vt1,' ',kytu);
               4: writeln(fo,vt1);
            end;
         end;
   close(fo);
end;

procedure CapPhat;
var i: integer;
begin
   for i:=0 to maxN do new(F[i]);
   for i:=0 to maxN do new(Tr[i]);
end;

BEGIN
   CapPhat;
   Docdl;
   Tinh;
   Tim;
   Inkq;
END.