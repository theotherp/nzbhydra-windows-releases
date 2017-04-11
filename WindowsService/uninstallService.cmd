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
echo Stopping service
call "%~dp0nssm.exe" stop NzbHydra
if %errorlevel% neq 0 goto failure
echo Uninstalling service
call "%~dp0nssm.exe" remove nzbhydra confirm
if %errorlevel% neq 0 goto failure
pause
goto eof

:failure
echo An error occured while uninstalling the service.
pause

:eof