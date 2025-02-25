@echo off
:: ensure the correct working directory is set when running as admin via the right click menu
pushd %~dp0

setlocal
set file=Balatro.exe

call :setsize %file%

IF NOT EXIST %file% (
	echo Couldn't find %file%. Copy these files to Balatro's game directory and run apply_readabletro.cmd again.
	pause
	goto :eof
)

if %size% EQU 56381239 goto :sizeok

echo %file% has an unexpected size - only an unmodified version 1.0.1o-FULL is supported.
pause
goto :eof

:sizeok

readabletro\helpers\dd if=%file% of=b.exe bs=394752 count=1
readabletro\helpers\dd if=%file% of=b.zip bs=394752 skip=1

readabletro\helpers\7z a b.zip .\readabletro\mod\* || goto :error

del Balatro.exe.bak
ren Balatro.exe Balatro.exe.bak
copy /y /b b.exe+b.zip Balatro.exe
del b.exe
del b.zip

echo Done!
pause

goto :eof

:error
echo Error.
pause
goto :eof

:setsize
set size=%~z1
goto :eof
