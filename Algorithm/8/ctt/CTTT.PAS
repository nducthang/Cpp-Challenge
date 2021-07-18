const
  INP = 'CTT.INP';
  OUT = 'CTT.OUT';
  MaxN = 1000;
  Infinity =1000000000;

type
  PNode = ^TNode;
  TNode = record
            v, w : Integer;
            Next : PNode;
          end;
  TDist = array[1..MaxN] of LongInt;

var
  List : array[1..MaxN] of PNode;
  Dist1, Dist2 : TDist;
  Chon : array[1..MaxN] of Byte;
  N : Integer;
  f : Text;
  Result : LongInt;

procedure Add(u, v, w : Integer);
var
  tmp : PNode;
begin
  New(tmp);
  tmp^.v:=v; tmp^.w:=w;
  tmp^.Next:=List[u];
  List[u]:=tmp;
end;

procedure Init;
var
  i, u, v, w : Integer;
  M : LongInt;
begin
  Assign(f, INP); Reset(f);
  Readln(f, N, M);
  for i:=1 to N do
    List[i]:=nil;
  for i:=1 to M do
    begin
      Readln(f, u, v, w);
      Add(u, v, w);
      Add(v, u, w);
    end;
  Close(f);
end;

procedure Dijkstra(Start : Integer; var Dist : TDist);
var
  Heap, Pos : array[1..MaxN] of Integer;
  Chua : array[1..MaxN] of Boolean;
  Last, i : Integer;
  HeapSize : Integer;
  tmp : PNode;

  procedure UpHeap(i : Integer);
  var
    x, c, r : Integer;
  begin
    x:=Heap[i];
    c:=i; r:=i shr 1;
    while r > 0 do
      begin
        if Dist[Heap[r]] > Dist[x] then
          begin
            Heap[c]:=Heap[r];
            Pos[Heap[r]]:=c;
          end
        else
          Break;
        c:=r; r:=r shr 1;
      end;
    Heap[c]:=x;
    Pos[x]:=c;
  end;

  procedure DownHeap(i : Integer);
  var
    x, c, r : Integer;
  begin
    x:=Heap[i];
    c:=i; r:=i shl 1;
    while r <= HeapSize do
      begin
        if (r < HeapSize) and (Dist[Heap[r]] > Dist[Heap[r+1]]) then
          Inc(r);
        if Dist[Heap[r]] < Dist[x] then
          begin
            Heap[c]:=Heap[r];
            Pos[Heap[r]]:=c;
          end
        else
          Break;
        c:=r; r:=r shl 1;
      end;
    Heap[c]:=x;
    Pos[x]:=c;
  end;

  function Extract : Integer;
  begin
    Extract:=Heap[1];
    Heap[1]:=Heap[HeapSize];
    Pos[Heap[HeapSize]]:=1;
    Dec(HeapSize);
    DownHeap(1);
  end;

begin
  FillChar(Chua, Sizeof(Chua), True);
  for i:=1 to N do
    Dist[i]:=Infinity;
  Chua[Start]:=False;
  Dist[Start]:=0;
  HeapSize:=0;
  for i:=1 to N do
    if i <> Start then
      begin
        Inc(HeapSize);
        Heap[HeapSize]:=i;
        Pos[i]:=HeapSize;
      end;
  Last:=Start;
  for i:=2 to N do
    begin
      tmp:=List[Last];
      while tmp <> nil do
        begin
          if Chua[tmp^.v] and (Dist[Last] + tmp^.w < Dist[tmp^.v]) then
            begin
              Dist[tmp^.v]:=Dist[Last] + tmp^.w;
              UpHeap(Pos[tmp^.v]);
            end;
          tmp:=tmp^.Next;
        end;
      Last:=Extract;
    end;
end;

procedure Process;
var
  Sub : array[1..MaxN] of LongInt;
  cs : array[1..MaxN] of Integer;
  i : Integer;

  procedure QuickSort(l, r : Integer);
  var
    x : LongInt;
    i, j, tmp : Integer;
  begin
    if l >= r then Exit;
    x:=Sub[cs[Random(r-l+1)+l]];
    i:=l; j:=r;
    repeat
      while (i < r) and (Sub[cs[i]] < x) do Inc(i);
      while (j > l) and (Sub[cs[j]] > x) do Dec(j);
      if i <= j then
        begin
          if i < j then
            begin
              tmp:=cs[i];
              cs[i]:=cs[j];
              cs[j]:=tmp;
            end;
          Inc(i); Dec(j);
        end;
    until i > j;
    QuickSort(l, j); QuickSort(i, r);
  end;

begin
  Dijkstra(1, Dist1);
  Dijkstra(2, Dist2);
  for i:=1 to N do
    begin
      cs[i]:=i;
      Sub[i]:=Dist1[i] - Dist2[i];
    end;
  QuickSort(1, N);
  Result:=0;
  for i:=1 to N div 2 do
    begin
      Chon[cs[i]]:=1;
      Inc(Result, Dist1[cs[i]]);
    end;
  for i:=N div 2 + 1 to N do
    begin
      Chon[cs[i]]:=2;
      Inc(Result, Dist2[cs[i]]);
    end;
  Writeln('Result : ', Result);
end;

procedure Done;
var
  i : Integer;
begin
  Assign(f, OUT); Rewrite(f);
  for i:=1 to N do
    if Chon[i] = 1 then
      Write(f, i, ' ');
  Writeln(f);
  for i:=1 to N do
    if Chon[i] = 2 then
      Write(f, i, ' ');
  Close(f);
end;

BEGIN
  Init;
  Process;
  Done;
END.