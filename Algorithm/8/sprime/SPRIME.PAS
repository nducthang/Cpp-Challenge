const
   tfi                             =     'SPRIME.INP';
   tfo                             =     'SPRIME.OUT';
   NT: array[1..168] of integer    =
       (  2,  3,  5,  7, 11, 13, 17, 19, 23, 29,
         31, 37, 41, 43, 47, 53, 59, 61, 67, 71,
         73, 79, 83, 89, 97,101,103,107,109,113,
        127,131,137,139,149,151,157,163,167,173,
        179,181,191,193,197,199,211,223,227,229,
        233,239,241,251,257,263,269,271,277,281,
        283,293,307,311,313,317,331,337,347,349,
        353,359,367,373,379,383,389,397,401,409,
        419,421,431,433,439,443,449,457,461,463,
        467,479,487,491,499,503,509,521,523,541,
        547,557,563,569,571,577,587,593,599,601,
        607,613,617,619,631,641,643,647,653,659,
        661,673,677,683,691,701,709,719,727,733,
        739,743,751,757,761,769,773,787,797,809,
        811,821,823,827,829,839,853,857,859,863,
        877,881,883,887,907,911,919,929,937,941,
        947,953,967,971,977,983,991,997);

var
   a                       :     array[0..1000] of integer;
   fi, fo                  :     text;
   N                       :     integer;

procedure ChuanBi;
var max,i,j,k: integer;
begin
   (* Qui hoach lan 1 *)
   for i:=1 to 1000 do a[i]:=-1;
   a[0]:=0;
   max:=0;
   for i:=1 to 168 do
      begin
         j:=max;
         while j>=0 do
            begin
               if (a[j]>-1) and (j+NT[i]<=1000) and (a[j+NT[i]]<a[j]+1) then
                  begin
                     a[j+NT[i]]:=a[j]+1;
                     if max<j+NT[i] then max:=j+NT[i];
                  end;
               dec(j);
            end;
      end;

   (* Qui hoach lan 2 *)
   for i:=1000 downto 2 do
      begin
         k:=1;
         while (k<=168) and (NT[k]<=i) do
            begin
               if (a[i-NT[k]]>-1) and (a[i]<a[i-NT[k]]+1) then
                  a[i]:=a[i-NT[k]]+1;
               inc(k);
            end;
      end;
   a[1]:=1;
end;

BEGIN
   ChuanBi;
   assign(fi,tfi); reset(fi);
   assign(fo,tfo); rewrite(fo);
   while not seekeof(fi) do
      begin
         readln(fi,N);
         writeln(fo,a[N]);
      end;
   close(fi); close(fo);
END.