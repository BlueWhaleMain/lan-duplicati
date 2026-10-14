@if not defined DEBUG echo off
set PATH=%PATH%;"%~dp0\scripts"
call env.cmd
if ErrorLevel 1 goto failure

if not exist ..\dev_runtime md ..\dev_runtime
if ErrorLevel 1 goto failure

if not exist ..\dev_runtime\home if not ..\dev_runtime\home == %HOME_DIR% (
    call evolution.cmd mklink /D ..\dev_runtime\home %HOME_DIR%
    if ErrorLevel 1 goto failure
)

if not exist ..\dev_runtime\volumes md ..\dev_runtime\volumes
if ErrorLevel 1 goto failure

set DOCKER_VOLUMES_DIR=%DOCKER_ROOT_DIR%\var\lib\docker\volumes

for /f %%i in ('docker compose volumes -q') do (
    if not exist ..\dev_runtime\volumes\%%i if exist %DOCKER_VOLUMES_DIR%\%%i\_data (
        call evolution.cmd mklink /D ..\dev_runtime\volumes\%%i %DOCKER_VOLUMES_DIR%\%%i\_data
        if ErrorLevel 1 goto failure
    )
)

if not exist docker-compose.override.yml if exist %HOME_DIR%\docker-compose.override.yml (
    call evolution.cmd mklink docker-compose.override.yml %HOME_DIR%\docker-compose.override.yml
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
