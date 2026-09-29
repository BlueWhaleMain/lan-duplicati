@if not defined DEBUG echo off

if "%~1" == "" goto failure

echo Run `%*` as Administrator.

:input_loop
set input=
set /p input=continue? [y/n]:
if "%input%" == "y" goto next
if "%input%" == "n" goto complete
echo please check input and repeat.
goto input_loop

:next

net session 2>nul 1>nul && goto dry_run
set SCRIPT_NAME=%RANDOM%.cmd
echo %* > %SCRIPT_NAME%
echo Start-Process "cmd" -ArgumentList "/c @echo off & pushd %cd% && call %SCRIPT_NAME% 2>&1 > %SCRIPT_NAME%.out & del %SCRIPT_NAME%" -Verb RunAs | powershell && goto result
del %SCRIPT_NAME%
echo evolution failed! Please run as Administrator.
goto failure

:result
if exist %SCRIPT_NAME% (
    echo Please wait the script complete.
    pause
    goto result
)
type %SCRIPT_NAME%.out
del %SCRIPT_NAME%.out
goto complete

:dry_run
%*
if ErrorLevel 1 goto failure

:complete
goto end

:failure
if ErrorLevel 1 goto end
:: strict fail
echo [1] %0 %*
exit /b 1

:end
if ErrorLevel 1 echo [%ErrorLevel%] %0 %*
exit /b %ErrorLevel%
