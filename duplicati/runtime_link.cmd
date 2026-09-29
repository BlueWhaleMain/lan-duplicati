@if not defined DEBUG echo off
set PATH=%PATH%;"%~dp0\scripts"
call env.cmd
if ErrorLevel 1 goto failure

if not exist ..\dev_runtime if not ..\dev_runtime == %SCRIPTS_RUNTIME_DIR% (
    call evolution.cmd mklink /D ..\dev_runtime %SCRIPTS_RUNTIME_DIR%
    if ErrorLevel 1 goto failure
)

if not exist docker-compose.override.yml if exist %SCRIPTS_RUNTIME_DIR%\docker-compose.override.yml (
    call evolution.cmd mklink docker-compose.override.yml %SCRIPTS_RUNTIME_DIR%\docker-compose.override.yml
    if ErrorLevel 1 goto failure
)

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
