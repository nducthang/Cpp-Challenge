cls
@echo off
echo ===================================================
echo              CHUONG TRINH CHAM BAI SON BANG
echo ===================================================
echo .
echo ============= CHAM TEST: PANO.IN%1 ================
del *.INP
del *.OUT
copy PANO.IN%1 PANO.INP
% echo ========= Chuan bi chay chuong trinh
% tg  > Tbegin.txt
Pano 
if errorlevel 1 goto Err
tg  > Tend.txt
echo ========= Ket thuc chay chuong trinh
echo .
CompTime
echo .
echo ========= Chay chuong trinh cham
echo .
echo .
PanoChk %1
goto End
:Err
echo      Runtime error!
echo                            *****************************
echo                                       Diem: 0
echo                            *****************************
:End
pause
