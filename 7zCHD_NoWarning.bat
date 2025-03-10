@echo off
TITLE 7zCHD V2

for /r %%I in (*.chd) do if exist "%%I" goto ExtractChd
goto DiscCheck

:ExtractChd
if not exist "chdman.exe" goto CHDError
echo.
echo		CHD files detected in rom folder, please select an extraction format:
echo		1 = CUE/BIN (Everything except most PS2 or Dreamcast games)
echo		2 = ISO (Most PS2 games)
echo		3 = GDI (All Dreamcast games)
echo		4 = ERROR (Only select this if ISO gives you an error)
echo		If you don't want to extract press any other key to exit.
set /p s= 

IF "%s%" == "1"    GOTO CUE
IF "%s%" == "2"    GOTO ISO
IF "%s%" == "3"    GOTO GDI
IF "%s%" == "4"    GOTO ISOError
exit

:CUE
for /r %%i in (*.chd) do ( chdman extractcd -i "%%i" -o "%%~ni.cue"
echo. )
goto finish

:ISO
for /r %%i in (*.chd) do ( chdman extractdvd -i "%%i" -o "%%~ni.iso"
echo. )
goto finish

:GDI
for /r %%i in (*.chd) do ( chdman extractcd -i "%%i" -o "%%~ni.gdi"
echo. )
goto finish

:ISOError
for /r %%i in (*.chd) do (
chdman extractcd -i "%%i" -o "%%~ni.cue" -ob "%%~ni.iso"
del "%%~ni.cue"
echo. )
goto finish

:finish
set counta=0
for /r %%a in (*.chd) do set /a counta+=1
set countb=0
for /r %%a in (*cue *iso *.gdi) do set /a countb+=1
set /a countc=%counta%-%countb%
if "%countc%"=="0" ( del /s *.chd
for /d /r %%d in (*.*) do rd "%%d"
exit )
echo				ERROR:
echo		There are %countc% more input files than there were extracted files!
echo			Source files will not be deleted.
echo		If you get this error while extracting PS2 CHDs to ISO there are 2
echo		possible reasons. A) The game is one of the extremely few CD games on
echo		PS2 and can be extracted using Option 1. B) The game is an ISO file
echo		that was incorrectly compressed to CHD using cd format and you
echo		can fix that with Option 4.
echo		Redump.org will tell you if the game is DVD or CD under "Media".
pause
exit


:DiscCheck
for /r %%I in (*.cue) do if exist "%%I" goto CHD
for /r %%I in (*.gdi) do if exist "%%I" goto CHD
for /r %%I in (*.iso) do if exist "%%I" goto CHD
goto ArchiveCheck

:CHD
if not exist "chdman.exe" goto CHDError
for /r %%i in (*.cue *.gdi) do ( chdman createcd -i "%%i" -o "%%~ni.chd"
echo. )
for /r %%i in (*.iso) do ( chdman createdvd -i "%%i" -o "%%~ni.chd"
echo. )
set counta=0
for /r %%a in (*cue *iso *.gdi) do set /a counta+=1
set countb=0
for /r %%a in (*.chd) do set /a countb+=1
set /a countc=%counta%-%countb%
if "%countc%"=="0" ( del /s *.cue *.bin *.gdi *.iso *raw *img
for /d /r %%d in (*.*) do rd "%%d"
exit )
echo				ERROR:
echo		There are %countc% more input files than there were compressed files!
echo			Source files will not be deleted.
pause
exit

:ArchiveCheck
if exist "*.7z" goto ZipError
if exist "*.bz2" goto ZipError
if exist "*.gz" goto ZipError
if exist "*.rar" goto ZipError
if exist "*.tar" goto ZipError
if exist "*.wim" goto ZipError
if exist "*.xz" goto ZipError
if exist "*.zip" goto ZipError


if not exist "C:\Program Files\7-Zip\7z.exe" goto 7zError
for %%i in (*) do (if not "%%~xi" == ".bat" (
	if not "%%i" == "chdman.exe" "C:\Program Files\7-Zip\7z.exe" a "%%~ni.7z" "%%i" -sdel))
for /d %%d in (*.*) do "C:\Program Files\7-Zip\7z.exe" a "%%d.7z" ".\%%d\*"
for /d %%a in (*.*) do rd /s /q "%%a"
exit

:CHDError
cls
echo.
echo		"chdman.exe" not found in this directory.
echo		Please download and install the free program "MAME" before running again.
echo		Copy "chdman.exe" from the "Mame" folder and keep it with this .bat file.
pause
exit

:7zError
cls
echo.
echo		7z.exe not found in "C:\Program Files\7-Zip\".
echo		Please download and install this free program before running again.
pause
exit

:ZipError
echo		Compressed archive in folder (.7z,.bz2, .gz, .rar, .tar, .wim, .xz, .zip)!
echo		Please extract before running the program again.
pause
exit
