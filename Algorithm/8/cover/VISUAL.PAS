{
**************************************************************************
                        VISUAL INTERFACE LIBRARY
                       (C) 2001  by Le Minh Hoang
**************************************************************************
}
{$A+,B-,D+,E+,F-,G+,L+,N+,O-,P-,T-,V+,X+,Y+}
{$R-,S-,Q-,I-}
unit Visual;
interface
  const
    Color: Byte = 30;
    Shadow: Boolean = True;
  type
    TBuffer = array[1..25, 1..80, 1..2] of Byte;
    TCBuffer = array[1..25, 1..80, 1..2] of Char;
    TCharBuffer = array[0..255, 0..15] of Byte;
    TSaveScr = record
      cX, cY, x1, y1, x2, y2: Integer;
      Buffer: TBuffer;
    end;
  procedure SaveScr(var s: TSaveScr);
  procedure RestoreScr(var s: TSaveScr);
  procedure InitMode;
  procedure Caption(S: String);
  procedure FlatFrame(x1, y1, x2, y2: Integer; Caption: String);
  procedure Frame(x1, y1, x2, y2: Integer; Caption: String);
  procedure Msg(xc, yc: Integer; Caption, Text: String);
  function ReadKey: Char;
  procedure Default;
  procedure Logo(S1, S2: String);

  procedure GetDefaultFont(var Buffer: TCharBuffer);
  procedure SetFont(var Buffer: TCharBuffer);
  procedure SaveFont(Filename: string; var Buffer: TCharBuffer);
  procedure LoadFont(Filename: string; var Buffer: TCharBuffer);
  procedure RestoreDefaultFont;
  procedure GetFontAccess;
  procedure ReleaseFontAccess;
  procedure GetFont(var Buffer: TCharBuffer);
  procedure ResetCharWidth(width: Byte);

implementation
uses crt, dos;
type

  TDragon = object
    private
      L: String;
      x, y: array[0..255] of Byte;
      x1, y1, x2, y2, n: Byte;
      procedure r(var px, py: Byte);
    public
      c: Byte;
      constructor Init(S: String);
      destructor Destroy;
      procedure Move1;
      procedure Display(var B: TBuffer);
  end;

var
  a: TBuffer absolute $B800:0;
  b: TCBuffer absolute a;
  SaveExit: Pointer;

procedure ResetCharWidth(width: Byte);
var
  x: Byte;
  r: Registers;
begin
  if (width <> 8) and (width <> 9) then Exit;
  if width = 8 then r.BX := $0001
  else r.BX := $0800;
  x := Port[$3CC] and not (4 + 8);
  if width = 9 then x := x or 4;
  Port[$3C2] := x;
  inline($FA);
  portw[$3C4] := $0100;
  Portw[$3C4] := $01 + r.BL shl 8;
  Portw[$3C4] := $0300;
  inline($FB);
  R.AX := $1000;
  R.BL := $13;
  Intr($10, r);
end;

procedure GetDefaultFont(var Buffer: TCharBuffer);
var
  r: Registers;
  tmp: ^TCharBuffer;
begin
  with r do
    begin
      AX := $1130;
      BH := 6;
      Intr($10, r);
      tmp := Ptr(r.ES, r.BP);
      Buffer := tmp^;
    end;
end;

procedure SetFont(var Buffer: TCharBuffer);
var
  r: Registers;
begin
  r.AX := $1100;
  r.ES := Seg(Buffer);
  r.BP := Ofs(Buffer);
  r.CX := 256;
  r.DX := 0;
  r.BH := 16;
  r.BL := 0;
  Intr($10, r);
end;

procedure SaveFont(Filename: string; var Buffer: TCharBuffer);
const
  Bit: array[1..8] of Byte = (128, 64, 32, 16, 8, 4, 2, 1);
var
  f: Text;
  i, j, k: Integer;
begin
  Assign(f, Filename); Rewrite(f);
  for i := 0 to 255 do
    begin
      Writeln(f, i);
      for j := 0 to 15 do
        begin
          for k := 1 to 8 do
            if Buffer[i, j] and Bit[k] <> 0 then Write(f, '�')
            else Write(f, '.');
          Writeln(f);
        end;
    end;
  Close(f);
end;

procedure LoadFont(Filename: string; var Buffer: TCharBuffer);
const
  Bit: array[1..8] of Byte = (128, 64, 32, 16, 8, 4, 2, 1);
var
  f: Text;
  i, j, k: Integer;
  ch: Char;
begin
  GetDefaultfont(Buffer);
  Assign(f, Filename); Reset(f);
  while not SeekEof(f) do
    begin
      Readln(f, i);
      for j := 0 to 15 do
        begin
          Buffer[i, j] := 0;
          for k := 1 to 8 do
            begin
              Read(f, ch);
              if ch = '�' then Buffer[i, j] := Buffer[i, j] or Bit[k];
            end;
          Readln(f);
        end;
    end;
  Close(f);
end;

procedure RestoreDefaultFont;
var
  P: TCharBuffer;
begin
  ResetCharWidth(9);
  GetDefaultFont(P);
  SetFont(P);
end;

procedure GetFontAccess;
const
  sr: array[1..4] of Word = ($0100, $0402, $0704, $0300);
  gr: array[1..3] of Word = ($0204, $005, $0406);
var
  i: Byte;
begin
  Inline($FA);
  for i := 1 to 4 do
    Portw[$3C4] := sr[i];
  for i := 1 to 3 do
    portw[$3ce] := gr[i];
  Inline($FB);
end;

procedure ReleaseFontAccess;
const
  sr: array[1..4] of Word = ($0100, $0302, $0304, $0300);
  gr: array[1..3] of Word = ($0004, $1005, $0E06);
var
  i: Byte;
begin
  for i := 1 to 4 do portw[$3C4] := sr[i];
  for i := 1 to 3 do portw[$3CE] := gr[i];
end;

procedure GetFont(var Buffer: TCharBuffer);
var
  tmp: array[0..511, 0..15] of Byte;
  i: Integer;
begin
  GetFontAccess;
  Move(Ptr(SegA000, 0)^, tmp, SizeOf(tmp));
  ReleaseFontAccess;
  for i := 0 to 255 do
    Move(tmp[i shl 1], Buffer[i], 16);
end;

procedure InitCharSet;
const
  CharSet: TCharBuffer =
  (
    (  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0),
    (  0,   0, 126, 129, 165, 129, 129, 189, 153, 129, 129, 126,   0,   0,   0,   0),
    (  0,   0, 126, 255, 219, 255, 255, 195, 231, 255, 255, 126,   0,   0,   0,   0),
    (  0,   0,   0,   0, 108, 254, 254, 254, 254, 124,  56,  16,   0,   0,   0,   0),
    (  0,   0,   0,   0,  16,  56, 124, 254, 124,  56,  16,   0,   0,   0,   0,   0),
    (  0,   0,   0,  24,  60,  60, 231, 231, 231,  24,  24,  60,   0,   0,   0,   0),
    (  0,   0,   0,  24,  60, 126, 255, 255, 126,  24,  24,  60,   0,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0,  24,  60,  60,  24,   0,   0,   0,   0,   0,   0),
    (255, 255, 255, 255, 255, 255, 231, 195, 195, 231, 255, 255, 255, 255, 255, 255),
    (  0,   0,   0,   0,   0,  60, 102,  66,  66, 102,  60,   0,   0,   0,   0,   0),
    (255, 255, 255, 255, 255, 195, 153, 189, 189, 153, 195, 255, 255, 255, 255, 255),
    (  0,   0,  30,  14,  26,  50, 120, 204, 204, 204, 204, 120,   0,   0,   0,   0),
    (  0,   0,  60, 102, 102, 102, 102,  60,  24, 126,  24,  24,   0,   0,   0,   0),
    (  0,   0,  63,  51,  63,  48,  48,  48,  48, 112, 240, 224,   0,   0,   0,   0),
    (  0,   0, 127,  99, 127,  99,  99,  99,  99, 103, 231, 230, 192,   0,   0,   0),
    (  0,   0,   0,  24,  24, 219,  60, 231,  60, 219,  24,  24,   0,   0,   0,   0),
    (  0, 128, 192, 224, 240, 248, 254, 248, 240, 224, 192, 128,   0,   0,   0,   0),
    (  0,   2,   6,  14,  30,  62, 254,  62,  30,  14,   6,   2,   0,   0,   0,   0),
    (  0,   0,  24,  60, 126,  24,  24,  24, 126,  60,  24,   0,   0,   0,   0,   0),
    (  0,   0, 102, 102, 102, 102, 102, 102, 102,   0, 102, 102,   0,   0,   0,   0),
    (  0,   0, 127, 219, 219, 219, 123,  27,  27,  27,  27,  27,   0,   0,   0,   0),
    (  0, 124, 198,  96,  56, 108, 198, 198, 108,  56,  12, 198, 124,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0,   0,   0, 254, 254, 254, 254,   0,   0,   0,   0),
    (  0,   0,  24,  60, 126,  24,  24,  24, 126,  60,  24, 126,   0,   0,   0,   0),
    (  0,   0,  24,  60, 126,  24,  24,  24,  24,  24,  24,  24,   0,   0,   0,   0),
    (  0,   0,  24,  24,  24,  24,  24,  24,  24, 126,  60,  24,   0,   0,   0,   0),
    (  0,   0,   0,   0,   0,  24,  12, 254,  12,  24,   0,   0,   0,   0,   0,   0),
    (  0,   0,   0,   0,   0,  48,  96, 254,  96,  48,   0,   0,   0,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0, 192, 192, 192, 254,   0,   0,   0,   0,   0,   0),
    (  0,   0,   0,   0,   0,  36, 102, 255, 102,  36,   0,   0,   0,   0,   0,   0),
    (  0,   0,   0,   0,  16,  56,  56, 124, 124, 254, 254,   0,   0,   0,   0,   0),
    (  0,   0,   0,   0, 254, 254, 124, 124,  56,  56,  16,   0,   0,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0),
    (  0,   0,   0,  24,  60,  60,  60,  24,  24,  24,   0,  24,  24,   0,   0,   0),
    (  0,   0, 102, 102, 102,  36,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0),
    (  0,   0,   0,   0, 108, 108, 254, 108, 108, 108, 254, 108, 108,   0,   0,   0),
    (  0,  24,  24, 124, 198, 194, 192, 124,   6,   6, 134, 198, 124,  24,  24,   0),
    (  0,   0,   0,   0,   0, 194, 198,  12,  24,  48,  96, 198, 134,   0,   0,   0),
    (  0,   0,   0,  56, 108, 108,  56, 118, 220, 204, 204, 204, 118,   0,   0,   0),
    (  0,   0,  48,  48,  48,  96,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0),
    (  0,   0,   0,  12,  24,  48,  48,  48,  48,  48,  48,  24,  12,   0,   0,   0),
    (  0,   0,   0,  48,  24,  12,  12,  12,  12,  12,  12,  24,  48,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0, 102,  60, 255,  60, 102,   0,   0,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0,  24,  24, 126,  24,  24,   0,   0,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,  24,  24,  24,  48,   0,   0),
    (  0,   0,   0,   0,   0,   0,   0,   0, 254,   0,   0,   0,   0,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,  24,  24,   0,   0,   0),
    (  0,   0,   0,   0,   0,   2,   6,  12,  24,  48,  96, 192, 128,   0,   0,   0),
    (  0,   0,   0,  56, 108, 198, 198, 214, 214, 198, 198, 108,  56,   0,   0,   0),
    (  0,   0,   0,  24,  56, 120,  24,  24,  24,  24,  24,  24, 126,   0,   0,   0),
    (  0,   0,   0, 124, 198,   6,  12,  24,  48,  96, 192, 198, 254,   0,   0,   0),
    (  0,   0,   0, 124, 198,   6,   6,  60,   6,   6,   6, 198, 124,   0,   0,   0),
    (  0,   0,   0,  12,  28,  60, 108, 204, 254,  12,  12,  12,  30,   0,   0,   0),
    (  0,   0,   0, 254, 192, 192, 192, 252,   6,   6,   6, 198, 124,   0,   0,   0),
    (  0,   0,   0,  56,  96, 192, 192, 252, 198, 198, 198, 198, 124,   0,   0,   0),
    (  0,   0,   0, 254, 198,   6,   6,  12,  24,  48,  48,  48,  48,   0,   0,   0),
    (  0,   0,   0, 124, 198, 198, 198, 124, 198, 198, 198, 198, 124,   0,   0,   0),
    (  0,   0,   0, 124, 198, 198, 198, 126,   6,   6,   6,  12, 120,   0,   0,   0),
    (  0,   0,   0,   0,   0,  24,  24,   0,   0,   0,  24,  24,   0,   0,   0,   0),
    (  0,   0,   0,   0,   0,  24,  24,   0,   0,   0,  24,  24,  48,   0,   0,   0),
    (  0,   0,   0,   0,   6,  12,  24,  48,  96,  48,  24,  12,   6,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0, 126,   0,   0, 126,   0,   0,   0,   0,   0,   0),
    (  0,   0,   0,   0,  96,  48,  24,  12,   6,  12,  24,  48,  96,   0,   0,   0),
    (  0,   0,   0, 124, 198, 198,  12,  24,  24,  24,   0,  24,  24,   0,   0,   0),
    (  0,   0,   0,   0, 124, 198, 198, 222, 222, 222, 220, 192, 124,   0,   0,   0),
    (  0,   0,   0,  16,  56, 108, 198, 198, 254, 198, 198, 198, 198,   0,   0,   0),
    (  0,   0,   0, 252, 102, 102, 102, 124, 102, 102, 102, 102, 252,   0,   0,   0),
    (  0,   0,   0,  60, 102, 194, 192, 192, 192, 192, 194, 102,  60,   0,   0,   0),
    (  0,   0,   0, 248, 108, 102, 102, 102, 102, 102, 102, 108, 248,   0,   0,   0),
    (  0,   0,   0, 254, 102,  98, 104, 120, 104,  96,  98, 102, 254,   0,   0,   0),
    (  0,   0,   0, 254, 102,  98, 104, 120, 104,  96,  96,  96, 240,   0,   0,   0),
    (  0,   0,   0,  60, 102, 194, 192, 192, 222, 198, 198, 102,  58,   0,   0,   0),
    (  0,   0,   0, 198, 198, 198, 198, 254, 198, 198, 198, 198, 198,   0,   0,   0),
    (  0,   0,   0,  60,  24,  24,  24,  24,  24,  24,  24,  24,  60,   0,   0,   0),
    (  0,   0,   0,  30,  12,  12,  12,  12,  12, 204, 204, 204, 120,   0,   0,   0),
    (  0,   0,   0, 230, 102, 102, 108, 120, 120, 108, 102, 102, 230,   0,   0,   0),
    (  0,   0,   0, 240,  96,  96,  96,  96,  96,  96,  98, 102, 254,   0,   0,   0),
    (  0,   0,   0, 198, 238, 254, 254, 214, 198, 198, 198, 198, 198,   0,   0,   0),
    (  0,   0,   0, 198, 230, 246, 254, 222, 206, 198, 198, 198, 198,   0,   0,   0),
    (  0,   0,   0, 124, 198, 198, 198, 198, 198, 198, 198, 198, 124,   0,   0,   0),
    (  0,   0,   0, 252, 102, 102, 102, 124,  96,  96,  96,  96, 240,   0,   0,   0),
    (  0,   0,   0, 124, 198, 198, 198, 198, 198, 198, 214, 222, 124,  12,  14,   0),
    (  0,   0,   0, 252, 102, 102, 102, 124, 108, 102, 102, 102, 230,   0,   0,   0),
    (  0,   0,   0, 124, 198, 198,  96,  56,  12,   6, 198, 198, 124,   0,   0,   0),
    (  0,   0,   0, 126, 126,  90,  24,  24,  24,  24,  24,  24,  60,   0,   0,   0),
    (  0,   0,   0, 198, 198, 198, 198, 198, 198, 198, 198, 198, 124,   0,   0,   0),
    (  0,   0,   0, 198, 198, 198, 198, 198, 198, 198, 108,  56,  16,   0,   0,   0),
    (  0,   0,   0, 198, 198, 198, 198, 214, 214, 214, 254, 238, 108,   0,   0,   0),
    (  0,   0,   0, 198, 198, 108, 124,  56,  56, 124, 108, 198, 198,   0,   0,   0),
    (  0,   0,   0, 102, 102, 102, 102,  60,  24,  24,  24,  24,  60,   0,   0,   0),
    (  0,   0,   0, 254, 198, 134,  12,  24,  48,  96, 194, 198, 254,   0,   0,   0),
    (  0,   0,   0,  60,  48,  48,  48,  48,  48,  48,  48,  48,  60,   0,   0,   0),
    (  0,   0,   0,   0, 128, 192, 224, 112,  56,  28,  14,   6,   2,   0,   0,   0),
    (  0,   0,   0,  60,  12,  12,  12,  12,  12,  12,  12,  12,  60,   0,   0,   0),
    (  0,  16,  56, 108, 198,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 255,   0),
    (  0,  48,  48,  24,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0, 120,  12, 124, 204, 204, 204, 118,   0,   0,   0),
    (  0,   0,   0, 224,  96,  96, 120, 108, 102, 102, 102, 102, 124,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0, 124, 198, 192, 192, 192, 198, 124,   0,   0,   0),
    (  0,   0,   0,  28,  12,  12,  60, 108, 204, 204, 204, 204, 118,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0, 124, 198, 254, 192, 192, 198, 124,   0,   0,   0),
    (  0,   0,   0,  56, 108, 100,  96, 240,  96,  96,  96,  96, 240,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0, 118, 204, 204, 204, 204, 204, 124,  12, 204, 120),
    (  0,   0,   0, 224,  96,  96, 108, 118, 102, 102, 102, 102, 230,   0,   0,   0),
    (  0,   0,   0,  24,  24,   0,  56,  24,  24,  24,  24,  24,  60,   0,   0,   0),
    (  0,   0,   0,   6,   6,   0,  14,   6,   6,   6,   6,   6,   6, 102, 102,  60),
    (  0,   0,   0, 224,  96,  96, 102, 108, 120, 120, 108, 102, 230,   0,   0,   0),
    (  0,   0,   0,  56,  24,  24,  24,  24,  24,  24,  24,  24,  60,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0, 236, 254, 214, 214, 214, 214, 198,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0, 220, 102, 102, 102, 102, 102, 102,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0, 124, 198, 198, 198, 198, 198, 124,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0, 220, 102, 102, 102, 102, 102, 124,  96,  96, 240),
    (  0,   0,   0,   0,   0,   0, 118, 204, 204, 204, 204, 204, 124,  12,  12,  30),
    (  0,   0,   0,   0,   0,   0, 220, 118, 102,  96,  96,  96, 240,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0, 124, 198,  96,  56,  12, 198, 124,   0,   0,   0),
    (  0,   0,   0,  16,  48,  48, 252,  48,  48,  48,  48,  54,  28,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0, 204, 204, 204, 204, 204, 204, 118,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0, 102, 102, 102, 102, 102,  60,  24,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0, 198, 198, 214, 214, 214, 254, 108,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0, 198, 108,  56,  56,  56, 108, 198,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0, 198, 198, 198, 198, 198, 198, 126,   6,  12, 248),
    (  0,   0,   0,   0,   0,   0, 254, 204,  24,  48,  96, 198, 254,   0,   0,   0),
    (  0,   0,  14,  24,  24,  24, 112,  24,  24,  24,  24,  14,   0,   0,   0,   0),
    (  0,   0,  24,  24,  24,  24,   0,  24,  24,  24,  24,  24,   0,   0,   0,   0),
    (  0,   0, 112,  24,  24,  24,  14,  24,  24,  24,  24, 112,   0,   0,   0,   0),
    (  0,   0, 118, 220,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0),
    (  0,   0,   0,   0,  16,  56, 108, 198, 198, 198, 254,   0,   0,   0,   0,   0),
    (  0,   0,  60, 102, 194, 192, 192, 192, 194, 102,  60,  12,   6, 124,   0,   0),
    (  0,   0, 204,   0,   0, 204, 204, 204, 204, 204, 204, 118,   0,   0,   0,   0),
    (  0,  12,  24,  48,   0, 124, 198, 254, 192, 192, 198, 124,   0,   0,   0,   0),
    (  0,  16,  56, 108,   0, 120,  12, 124, 204, 204, 204, 118,   0,   0,   0,   0),
    (  0,   0, 204,   0,   0, 120,  12, 124, 204, 204, 204, 118,   0,   0,   0,   0),
    (  0,  96,  48,  24,   0, 120,  12, 124, 204, 204, 204, 118,   0,   0,   0,   0),
    (  0,  56, 108,  56,   0, 120,  12, 124, 204, 204, 204, 118,   0,   0,   0,   0),
    (  0,   0,   0,   0,  60, 102,  96,  96, 102,  60,  12,   6,  60,   0,   0,   0),
    (  0,  16,  56, 108,   0, 124, 198, 254, 192, 192, 198, 124,   0,   0,   0,   0),
    (  0,   0, 198,   0,   0, 124, 198, 254, 192, 192, 198, 124,   0,   0,   0,   0),
    (  0,  96,  48,  24,   0, 124, 198, 254, 192, 192, 198, 124,   0,   0,   0,   0),
    (  0,   0, 102,   0,   0,  56,  24,  24,  24,  24,  24,  60,   0,   0,   0,   0),
    (  0,  24,  60, 102,   0,  56,  24,  24,  24,  24,  24,  60,   0,   0,   0,   0),
    (  0,  96,  48,  24,   0,  56,  24,  24,  24,  24,  24,  60,   0,   0,   0,   0),
    (  0, 198,   0,  16,  56, 108, 198, 198, 254, 198, 198, 198,   0,   0,   0,   0),
    ( 56, 108,  56,   0,  56, 108, 198, 198, 254, 198, 198, 198,   0,   0,   0,   0),
    ( 24,  48,  96,   0, 254, 102,  96, 124,  96,  96, 102, 254,   0,   0,   0,   0),
    (  0,   0,   0,   0,   0, 110,  59,  27, 126, 216, 220, 119,   0,   0,   0,   0),
    (  0,   0,  62, 108, 204, 204, 254, 204, 204, 204, 204, 206,   0,   0,   0,   0),
    (  0,  16,  56, 108,   0, 124, 198, 198, 198, 198, 198, 124,   0,   0,   0,   0),
    (  0,   0, 198,   0,   0, 124, 198, 198, 198, 198, 198, 124,   0,   0,   0,   0),
    (  0,  96,  48,  24,   0, 124, 198, 198, 198, 198, 198, 124,   0,   0,   0,   0),
    (  0,  48, 120, 204,   0, 204, 204, 204, 204, 204, 204, 118,   0,   0,   0,   0),
    (  0,  96,  48,  24,   0, 204, 204, 204, 204, 204, 204, 118,   0,   0,   0,   0),
    (  0,   0, 198,   0,   0, 198, 198, 198, 198, 198, 198, 126,   6,  12, 120,   0),
    (  0, 198,   0, 124, 198, 198, 198, 198, 198, 198, 198, 124,   0,   0,   0,   0),
    (  0, 198,   0, 198, 198, 198, 198, 198, 198, 198, 198, 124,   0,   0,   0,   0),
    (  0,  24,  24, 126, 195, 192, 192, 192, 195, 126,  24,  24,   0,   0,   0,   0),
    (  0,  56, 108, 100,  96, 240,  96,  96,  96,  96, 230, 252,   0,   0,   0,   0),
    (  0,   0, 195, 102,  60,  24, 255,  24, 255,  24,  24,  24,   0,   0,   0,   0),
    (  0, 252, 102, 102, 124,  98, 102, 111, 102, 102, 102, 243,   0,   0,   0,   0),
    (  0,  14,  27,  24,  24,  24, 126,  24,  24,  24,  24,  24, 216, 112,   0,   0),
    (  0,  24,  48,  96,   0, 120,  12, 124, 204, 204, 204, 118,   0,   0,   0,   0),
    (  0,  68,  56,  16,  56, 108, 198, 198, 254, 198, 198, 198, 198,   0,   0,   0),
    ( 16,  56,  68,  16,  56, 108, 198, 198, 254, 198, 198, 198, 198,   0,   0,   0),
    ( 16,  40,   0, 254, 102,  98, 104, 120, 104,  96,  98, 102, 254,   0,   0,   0),
    ( 56, 108, 130,  56, 108, 198, 198, 198, 198, 198, 198, 108,  56,   0,   0,   0),
    (  0,  14,   2,  60, 108, 198, 198, 198, 198, 198, 198, 108,  56,   0,   0,   0),
    (  0,   7,   1, 198, 198, 198, 198, 198, 198, 198, 198, 198, 124,   0,   0,   0),
    (  0,   0,   0, 248, 108, 102, 102, 246, 102, 102, 102, 108, 248,   0,   0,   0),
    (  0,   0,   0, 204, 120,   0, 120,  12, 124, 204, 204, 204, 118,   0,   0,   0),
    (  0,   0,  48, 120, 204,   0, 120,  12, 124, 204, 204, 204, 118,   0,   0,   0),
    (  0,   0,  16,  56, 108,   0, 124, 198, 254, 192, 192, 198, 124,   0,   0,   0),
    (  0,   0,  48, 120, 204,   0, 124, 198, 198, 198, 198, 198, 124,   0,   0,   0),
    (  0,   0,   0,   0,  14,   6, 124, 198, 198, 198, 198, 198, 124,   0,   0,   0),
    (  0,   0,   0,   0,  14,   2, 204, 204, 204, 204, 204, 204, 118,   0,   0,   0),
    (  0,  12,  12,  30,  12,  12,  60, 108, 204, 204, 204, 204, 118,   0,   0,   0),
    (  0,   0,   0,   0,   0, 216, 108,  54, 108, 216,   0,   0,   0,   0,   0,   0),
    ( 17,  68,  17,  68,  17,  68,  17,  68,  17,  68,  17,  68,  17,  68,  17,  68),
    ( 85, 170,  85, 170,  85, 170,  85, 170,  85, 170,  85, 170,  85, 170,  85, 170),
    (221, 119, 221, 119, 221, 119, 221, 119, 221, 119, 221, 119, 221, 119, 221, 119),
    ( 24,  24,  24,  24,  24,  24,  24,  24,  24,  24,  24,  24,  24,  24,  24,  24),
    ( 35,  35,  19,  11,  11,  19,  35,  35,  35,  35,  19,  11,  11,  19,  35,  35),
    (  0,   0,  96,  48,  24,   0, 120,  12, 124, 204, 204, 204, 118,   0,   0,   0),
    (  0, 120,  24,  16,   0,   0, 120,  12, 124, 204, 204, 204, 118,   0,   0,   0),
    (  0,   0, 100, 152,   0,   0, 120,  12, 124, 204, 204, 204, 118,   0,   0,   0),
    (  0,   0,  24,  48,  96,   0, 120,  12, 124, 204, 204, 204, 118,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0, 120,  12, 124, 204, 204, 204, 118,   0,  48,  48),
    ( 54,  54,  54,  54,  54,  54,  54,  54,  54,  54,  54,  54,  54,  54,  54,  54),
    (192,  96,  32, 204, 120,   0, 120,  12, 124, 204, 204, 204, 118,   0,   0,   0),
    (120,  24,  16, 204, 120,   0, 120,  12, 124, 204, 204, 204, 118,   0,   0,   0),
    (118, 220,   0, 204, 120,   0, 120,  12, 124, 204, 204, 204, 118,   0,   0,   0),
    ( 12,  24,  16, 204, 120,   0, 120,  12, 124, 204, 204, 204, 118,   0,   0,   0),
    (255, 255, 255, 255, 255, 255, 255,   3, 255, 255, 255, 255, 255, 231, 195,   0),
    (196, 196, 200, 208, 208, 200, 196, 196, 196, 230, 249, 248, 252, 254, 255, 255),
    ( 24,  24,  24,  24,  24,  24,  24, 255,   0,   0,   0,   0,   0,   0,   0,   0),
    (255, 255, 255, 255, 255,   0, 255,   0, 255,   0, 255, 255, 255, 231, 195,   0),
    (196, 196, 200, 208, 208, 200, 196, 196, 196, 196, 200, 208, 208, 200, 196, 196),
    (  0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 195,  36,  24,   0, 255, 255),
    ( 24,  24,  24,  24,  24,  24,  24, 255,  24,  24,  24,  24,  24,  24,  24,  24),
    (  0,   0,   0, 204, 120,   0, 120,  12, 124, 204, 204, 204, 118,   0,  48,  48),
    ( 24,  12,  54, 120, 204,   0, 120,  12, 124, 204, 204, 204, 118,   0,   0,   0),
    ( 30,   6,  52, 120, 204,   0, 120,  12, 124, 204, 204, 204, 118,   0,   0,   0),
    (102, 152,  48, 120, 204,   0, 120,  12, 124, 204, 204, 204, 118,   0,   0,   0),
    ( 48,  96, 208,  56, 108,   0, 120,  12, 124, 204, 204, 204, 118,   0,   0,   0),
    (  0,   0,  48, 120, 204,   0, 120,  12, 124, 204, 204, 204, 118,   0,  48,  48),
    (  0,   0,  96,  48,  24,   0, 124, 198, 254, 192, 192, 198, 124,   0,   0,   0),
    (  0,   0,   0,   0,   0, 255,   0, 255,   0,   0,   0,   0,   0,   0,   0,   0),
    (  0,   0,  60,  12,   8,   0, 124, 198, 254, 192, 192, 198, 124,   0,   0,   0),
    (  0,   0, 100, 152,   0,   0, 124, 198, 254, 192, 192, 198, 124,   0,   0,   0),
    (  0,   0,  12,  24,  48,   0, 124, 198, 254, 192, 192, 198, 124,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0, 124, 198, 254, 192, 192, 198, 124,   0,  48,  48),
    ( 24,  12,  22,  56, 108,   0, 124, 198, 254, 192, 192, 198, 124,   0,   0,   0),
    ( 30,   2,  20,  56, 108,   0, 124, 198, 254, 192, 192, 198, 124,   0,   0,   0),
    (100, 152,  16,  56, 108,   0, 124, 198, 254, 192, 192, 198, 124,   0,   0,   0),
    ( 48,  96, 144,  56, 108,   0, 124, 198, 254, 192, 192, 198, 124,   0,   0,   0),
    (  0,   0,  16,  56, 108,   0, 124, 198, 254, 192, 192, 198, 124,   0,  48,  48),
    (  0,   0,  96,  48,  24,   0,  56,  24,  24,  24,  24,  24,  60,   0,   0,   0),
    (  0,  60,  12,  16,   0,   0,  56,  24,  24,  24,  24,  24,  60,   0,   0,   0),
    ( 35,  35,  19,  11,  11,  19,  35,  35,  35,  39, 255,  63,  63, 127, 255, 255),
    (255, 255, 255, 255, 255, 255, 255, 192, 255, 255, 255, 255, 255, 231, 195,   0),
    (255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255),
    (  0,  50,  76,   0,  24,   0,  56,  24,  24,  24,  24,  24,  60,   0,   0,   0),
    (  0,   0,  12,  24,  48,   0,  56,  24,  24,  24,  24,  24,  60,   0,   0,   0),
    (  0,   0,   0,  24,  24,   0,  56,  24,  24,  24,  24,  24,  60,   0,  24,  24),
    (  0,   0,  96,  48,  24,   0, 124, 198, 198, 198, 198, 198, 124,   0,   0,   0),
    (  0,   0,   0,   0,   0, 118, 220, 216, 216, 216, 220, 118,   0,   0,   0,   0),
    (  0,   0,  60,  12,  24,   0, 124, 198, 198, 198, 198, 198, 124,   0,   0,   0),
    (  0,   0,   0,  50, 204,   0, 124, 198, 198, 198, 198, 198, 124,   0,   0,   0),
    (  0,   0,  12,  24,  48,   0, 124, 198, 198, 198, 198, 198, 124,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0, 124, 198, 198, 198, 198, 198, 124,   0,  24,  24),
    ( 24,  12,  54, 120, 204,   0, 124, 198, 198, 198, 198, 198, 124,   0,   0,   0),
    ( 30,   2,  52, 120, 204,   0, 124, 198, 198, 198, 198, 198, 124,   0,   0,   0),
    (100, 152,  48, 120, 204,   0, 124, 198, 198, 198, 198, 198, 124,   0,   0,   0),
    ( 32,  96, 208,  56, 108,   0, 124, 198, 198, 198, 198, 198, 124,   0,   0,   0),
    (  0,   0,  48, 120, 204,   0, 124, 198, 198, 198, 198, 198, 124,   0,  48,  48),
    (  0, 192,  96,  32,  14,   6, 124, 198, 198, 198, 198, 198, 124,   0,   0,   0),
    (  0, 120,  24,  32,  14,   6, 124, 198, 198, 198, 198, 198, 124,   0,   0,   0),
    (  0, 102, 152,   0,  14,   6, 124, 198, 198, 198, 198, 198, 124,   0,   0,   0),
    (  0,  12,  24,  32,  14,   6, 124, 198, 198, 198, 198, 198, 124,   0,   0,   0),
    (  0,   0,   0,   0,  14,   6, 124, 198, 198, 198, 198, 198, 124,   0,  24,  24),
    (  0,   0, 192,  96,  48,   0, 204, 204, 204, 204, 204, 204, 118,   0,   0,   0),
    (  0,   0,   0,   0, 254,   0,   0, 254,   0,   0, 254,   0,   0,   0,   0,   0),
    (  0, 120,  24,  16,   0,   0, 204, 204, 204, 204, 204, 204, 118,   0,   0,   0),
    (  0,   0, 100, 152,   0,   0, 204, 204, 204, 204, 204, 204, 118,   0,   0,   0),
    (  0,   0,  12,  24,  48,   0, 204, 204, 204, 204, 204, 204, 118,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0, 204, 204, 204, 204, 204, 204, 118,   0,  48,  48),
    (  0, 192,  96,  32,  14,   2, 204, 204, 204, 204, 204, 204, 118,   0,   0,   0),
    (  0, 120,  24,  32,  14,   2, 204, 204, 204, 204, 204, 204, 118,   0,   0,   0),
    (  0, 100, 152,   0,  14,   2, 204, 204, 204, 204, 204, 204, 118,   0,   0,   0),
    (  0,  24,  48,  96,  14,   2, 204, 204, 204, 204, 204, 204, 118,   0,   0,   0),
    (  0,   0,   0,   0,  14,   2, 204, 204, 204, 204, 204, 204, 118,   0,  48,  48),
    (  0,   0, 192,  96,  48,   0, 198, 198, 198, 198, 198, 198, 126,   6,  12, 248),
    (  0,   0, 120,  24,  16,   0, 198, 198, 198, 198, 198, 198, 126,   6,  12, 248),
    (  0, 100, 152,   0,   0,   0, 198, 198, 198, 198, 198, 198, 126,   6,  12, 248),
    (  0,   0,  12,  24,  48,   0, 198, 198, 198, 198, 198, 198, 126,   6,  12, 248),
    (  0,   0,   0,   0,   0,   0, 198, 198, 198, 198, 198, 198, 126,   6, 108, 248),
    (  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0)

  );
begin
  ResetCharWidth(8);
  SetFont(CharSet);
end;

procedure InitMode;
var
  r: Registers;
begin
  TextMode(C80);
  r.AX := $1003;
  r.BL := 0;
  Intr($10, r);
  InitCharSet;
end;

procedure Caption(S: String);
var
  i, j: Integer;
begin
  for i := 1 to 24 do
    for j := 1 to 80 do
      begin
        a[i, j, 1] := 177;
        a[i, j, 2] := 136;
      end;
  Window(1, 1, 80, 25);
  GotoXY(1, 25); TextAttr :=  206; ClrEol;
  Write(S);
end;

procedure Refine(var x1, y1, x2, y2: Integer);
var
  w, h: Integer;
begin
  w := x2 - x1; h := y2 - y1;
  if x2 > 78 then
    begin
      x2 := 78; x1 := x2 - w;
    end;
  if y2 > 23 then
    begin
      y2 := 23; y1 := y2 - h;
    end;
  if x1 < 1 then
    begin
      x1 := 1; x2 := x1 + w;
    end;
  if y1 < 1 then
    begin
      y1 := 1; y2 := y1 + h;
    end;
end;

procedure FlatFrame(x1, y1, x2, y2: Integer; Caption: String);
var
  xc, i, j: Integer;
begin
  for i := x1 to x2 do
    for j := y1 to y2 do
      begin
        b[j, i, 1] := ' '; a[j, i, 2] := Color;
      end;
  b[y1, x1, 1] := '�'; b[y1, x2, 1] := '�';
  b[y1, x1 + 1, 1] := '�'; b[y1, x2 - 1, 1] := '�';
  b[y2, x1, 1] := '�'; b[y2, x2, 1] := '�';
  b[y2, x1 + 1, 1] := '�'; b[y2, x2 - 1, 1] := '�';
  for i := x1 + 2 to x2 - 2 do
    begin
      b[y1, i, 1] := '�'; b[y2, i, 1] := '�';
    end;
  for j := y1 + 1 to y2 - 1 do
    begin
      b[j, x1, 1] := '�'; b[j, x2, 1] := '�';
    end;
  Window(1, 1, 80, 25); TextAttr := Color;
  Caption := ' ' + Caption + ' ';
  xc := (x2 - x1 - Length(Caption)) div 2 + x1 + 1;
  GotoXY(xc, y1);
  TextAttr := (Color mod 16) * 16 + Color div 16;
  Write(Caption);
  Window(x1 + 2, y1 + 1, x2 - 2, y2 - 1); TextAttr := Color;
end;

procedure Frame(x1, y1, x2, y2: Integer; Caption: String);
var
  i, j: Integer;
begin
  Refine(x1, y1, x2, y2);
  if Shadow then
    begin
      for i := x1 + 2 to x2 + 2 do a[y2 + 1, i, 2] := 8;
      for j := y1 + 1 to y2 + 1 do
        begin
          a[j, x2 + 1, 2] := 8;
          a[j, x2 + 2, 2] := 8;
        end;
    end;
  FlatFrame(x1, y1, x2, y2, Caption);
end;

procedure Msg(xc, yc: Integer; Caption, Text: String);
var
  l, x1, y1, x2, y2: Integer;
begin
  if Length(Caption) + 2 < Length(Text) then l := Length(Text)
  else l := Length(caption) + 2;
  x1 := xc - l div 2 - 1; y1 := yc - 1;
  x2 := x1 + l + 4; y2 := yc + 1;
  Frame(x1, y1, x2, y2, Caption);
  Write(Text);
end;

procedure SaveScr(var S: TSaveScr);
begin
  with S do
    begin
      x1 := Lo(WindMin) + 1; y1 := Hi(WindMin) + 1;
      x2 := Lo(WindMax) + 1; y2 := Hi(WindMax) + 1;
      cX := WhereX; cY := WhereY;
      Move(a, S.Buffer, 4000);
    end;
end;

procedure RestoreScr(var S: TSaveScr);
begin
  with S do
    begin
      Window(x1, y1, x2, y2);
      GotoXY(cX, cY);
      Move(S.Buffer, a, 4000);
    end;
end;

function ReadKey: Char;
var
  ch: Char;
begin
  repeat
    ch := Crt.ReadKey;
  until not KeyPressed;
  ReadKey := ch;
end;

procedure Default;
begin
  Window(1, 1, 80, 25);
  TextAttr := a[1, 1, 2];
end;

procedure TDragon.R(var px, py: Byte);
begin
  px := Random(25) + 1; py := Random(80) + 1;
  if x1 < x2 then Inc(x1); if x1 > x2 then Dec(x1);
  if y1 < y2 then Inc(y1); if y1 > y2 then Dec(y1);
  Move(x[1], x[2], n - 1); Move(y[1], y[2], n - 1);
end;

constructor TDragon.Init(S: String);
begin
  S := '*****' + S + '*****';
  L := S; n := Length(S);
  Randomize;
  R(x1, y1); R(x2, y2);
  FillChar(x, SizeOf(x), x1);
  FillChar(y, SizeOf(y), y1);
end;

destructor TDragon.Destroy;
begin
end;

procedure TDragon.Move1;
begin
  if x1 < x2 then Inc(x1); if x1 > x2 then Dec(x1);
  if y1 < y2 then Inc(y1); if y1 > y2 then Dec(y1);
  if (x2 = x1) and (y2 = y1) then R(x2, y2);
  Move(x[1], x[2], n - 1); Move(y[1], y[2], n - 1);
  x[1] := x1; y[1] := y1;
end;

procedure TDragon.Display(var b: TBuffer);
var
  i: Integer;
begin
  for i := n downto 1 do
    begin
      b[x[i], y[i], 1] := Ord(L[i]);
      b[x[i], y[i], 2] := b[x[i], y[i], 2] and $F0 or c;
    end;
end;

procedure Logo(S1, S2: String);
var
  p: ^TBuffer;
  D1, D2: TDragon;
  i: Byte;
  S: TSaveScr;
begin
  SaveScr(S); New(p);
  D1.Init(S1); D2.Init(S2);
  D1.c := 14;
  D2.c := 4;
  i := 0;
  repeat
    Move(S.Buffer, p^, 4000);
    D1.Display(p^); D2.Display(p^);
    Move(p^, a, 4000);
    Delay(30);
    Inc(i);
    if i mod 3 = 1 then D1.Move1
    else D2.Move1;
    if Random(1000) = 1 then
      begin
        D1.c := Random(16);  D2.c := Random(16);
      end;
  until Keypressed;
  RestoreScr(S);
  Dispose(p);
  D1.Destroy;
  D2.Destroy;
end;

{$F+}
procedure CustomExit;
var
  r: Registers;
begin
  RestoreDefaultFont;
  ExitProc := SaveExit;
  r.AX := 3;
  Intr($10, r);
  r.AX := $1003;
  r.BL := 1;
  Intr($10, r);
end;
{$F-}

begin
  InitMode;
  SaveExit := ExitProc;
  ExitProc := @CustomExit;
end.
