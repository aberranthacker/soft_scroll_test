@echo on
@if exist MAIN.LST del MAIN.LST
@if exist MAIN.OBJ del MAIN.OBJ
@if exist MAIN.SAV del MAIN.SAV
@if exist MAIN.BIN del MAIN.BIN
@if exist OUTPUT.MAP del OUTPUT.MAP

@echo off
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "DATESTAMP=%YYYY%-%MM%-%DD%"

echo REV.%REVISION% %DATESTAMP%

echo VERSTR:	.ASCIZ /REV.%REVISION% %DATESTAMP%/ > VERSIO.MAC
echo	.EVEN >> VERSIO.MAC

@echo on
@if exist MAIN.LST del MAIN.LST
@if exist MAIN.OBJ del MAIN.OBJ
::rt11.exe MACRO/LIST:DK: MAIN.MAC+SYSMAC.SML/LIBRARY
rt11.exe MACRO MAIN.MAC+SYSMAC.SML/LIBRARY

rt11.exe LINK MAIN /MAP:OUTPUT.MAP
@if exist OUTPUT.MAP type OUTPUT.MAP

@echo off
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "DATESTAMP=%YYYY%-%MM%-%DD%"

echo REV.%REVISION% %DATESTAMP%

echo VERSTR:	.ASCIZ /REV.%REVISION% %DATESTAMP%/ > VERSIO.MAC
echo	.EVEN >> VERSIO.MAC

@echo on
@if exist MAIN.BIN del MAIN.BIN
::E:\retrodev\bin\Sav2Cart.exe MAIN.SAV MAIN.BIN
pause
