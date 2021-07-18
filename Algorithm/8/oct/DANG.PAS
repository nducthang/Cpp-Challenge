{$R+,Q+,N+,B-}
program oct;
const
  nfi='oct.inp';
  nfo='oct.out';
  limit=200;
type
  ar=array[1..limit,1..limit]of byte;
var
  fi,fo:text;
  n,c:byte;
  a:array[0..7,0..7]of byte;
  b:array[1..limit]of byte;
  e,f,g:^ar;
procedure allot;
  begin
    new(e);
    fillchar(e^,sizeof(e^),0);
    new(f);
    fillchar(f^,sizeof(f^),0);
    new(g);
    fillchar(g^,sizeof(g^),0);
  end;
procedure input;
  var
    i,j:byte;
  begin
    assign(fi,nfi);reset(fi);
    for i:=0 to 7 do
      for j:=0 to 7 do read(fi,a[i,j]);
    read(fi,n);
    for i:=1 to n do read(fi,b[i]);
    read(fi,c);
    close(fi);
  end;
procedure process;
  var
    i,j,k,l,x,y:byte;
  begin
    for i:=1 to n do f^[i,i]:=f^[i,i] or (1 shl b[i]);
    for l:=2 to n do
      for i:=1 to n-l+1 do
      begin
        j:=i+l-1;
        for x:=0 to 7 do
          for y:=0 to 7 do
            if (f^[i,j] shr a[x,y])and 1=0 then
              for k:=i to j-1 do
                if (f^[i,k] shr x)and 1 =1 then
                  if (f^[k+1,j] shr y)and 1=1 then
                  begin
                    f^[i,j]:=f^[i,j] or (1 shl a[x,y]);
                    e^[i,j]:=e^[i,j] or (1 shl x);
                    g^[i,j]:=g^[i,j] or (1 shl y);
                  end;
      end;
  end;
procedure trace(i,j,z:byte);
  var
    k,x,y:byte;
  begin
    if i=j then exit;
    for k:=1 to j-1 do
      for x:=0 to 7 do
        for y:=0 to 7 do
          if (f^[i,k] shr x)and 1=1 then
            if (f^[k+1,j] shr y)and 1=1 then
              if a[x,y]=z then
              begin
                trace(k+1,j,y);
                trace(i,k,x);
                write(fo,i,' ');
                exit;
              end;
  end;
procedure output;
  begin
    assign(fo,nfo);rewrite(fo);
    trace(1,n,c);
    close(fo);
  end;
begin
  allot;
  input;
  process;
  output;
end.