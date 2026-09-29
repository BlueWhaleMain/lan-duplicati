@if not defined DEBUG echo off
set PATH=%PATH%;"%~dp0\scripts"
call env.cmd
if ErrorLevel 1 goto failure

%ComSpec%
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
