@echo off

net session >nul 2>&1
if %errorLevel% == 0 (
	echo Administrator rights confirmed.
	goto install
) else (
	echo You need to run this script with administrator rights.
	pause
	goto eof
)

:install
echo Installing service
call "%~dp0nssm.exe" install NzbHydra "%%~dp0..\nzbhydra.exe"
if %errorlevel% neq 0 goto failure
echo Setting service exe
call "%~dp0nssm.exe" set NzbHydra Application "%~dp0..\nzbhydra.exe"
if %errorlevel% neq 0 goto failure
echo Setting service folder
call "%~dp0nssm.exe" set NzbHydra AppDirectory "%~dp0.."
if %errorlevel% neq 0 goto failure
echo Service installed successfully. Starting service...
call "%~dp0nssm.exe" start NzbHydra
pause
goto eof

:failure
echo An error occured while installing the service.
pause

:eof