{$r+$q+}
uses crt;
const
    fin: string = 'BOTTLES.INq';
    fou: string = 'BOTTLES.OUT';
    maxsize = 50000;
    dapso: array['0'..'9'] of longint =
    (33340000,
    334000,
    24641214,
    2299292,
    772562,
    97632,
    117079,
    16338000,
    21338667,
    175574);
type
   arr5 = array[0..maxsize] of byte;
var
   n, ndem, nbot, fmax: longint;
   sel     :  arr5;
   f       :  text;
   chon: char;
   diem: integer;

procedure Cham;
var i, j, sum, Count, k: longint;
begin
    diem:=0;
    fillchar(sel, sizeof(sel), 0);
    assign(f,fin); reset(f);
    readln(f, n); close(f);
    assign(f,fou); reset(f);
    readln(f, k, sum);
    writeln;
    writeln('Ket qua tren file: ',k,'  ', sum);
    writeln;
    for i:=1 to k do
    begin
        read(f,j);
        if (j<0) or (j>n) then
        begin
            writeln('?????????????????????????????????????????????');
            writeln('      ERROR:   Khong co chi so: ',j);
            writeln('?????????????????????????????????????????????');
            exit;
        end;
        sel[j]:=1;
    end;
    close(f);
    assign(f,fin); reset(f);
    readln(f, n);
    Count:=0;
    for i:=1 to n do
    begin
        readln(f,j);
        if sel[i]=1 then Count:=count+j;
    end;
    close(f);
    if count<>sum then
    begin
        writeln('?????????????????????????????????????????????');
        writeln('      ERROR:   Tinh tong khong dung: ');
        writeln('                          Tinh duoc: ',count);
        writeln('                          Thong bao: ',sum);
        writeln('?????????????????????????????????????????????');
        exit;
    end;
    if sum<dapso[chon] then
    begin
        writeln('?????????????????????????????????????????????');
        writeln('      ERROR:   Khong toi uu! ');
        writeln('                  Tinh duoc: ',count);
        writeln('                  Dap so   : ',dapso[chon]);
        writeln('?????????????????????????????????????????????');
        exit;
    end;
    diem:=1;
    writeln;
    writeln('                   ******************************');
    writeln('                          C O R R E C T !');
    writeln('                   ******************************');
    writeln;
end;


BEGIN
    clrscr;
    writeln('         ================================================');
    writeln('                 CHUONG TRINH CHAM BAI: BOTTLES');
    writeln('         ================================================');
    write  ('               Ten file du lieu BOTTLES.IN');
    chon:=readkey; writeln(chon);
    fin:='BOTTLES.IN'+chon;
    Cham;
    writeln;    writeln;    writeln;
    writeln('                   $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
    writeln('                              Diem: ',diem);
    writeln('                   $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
    writeln;
    readln;
END.
