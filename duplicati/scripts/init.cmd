@if not defined DEBUG echo off
call env.cmd
if ErrorLevel 1 goto failure

echo find old configure %SCRIPTS_RUNTIME_DIR%\duplicati.env ...
type %SCRIPTS_RUNTIME_DIR%\duplicati.env | wsl grep -w SETTINGS_ENCRYPTION_KEY
if ErrorLevel 1 goto init

:input_loop
set input=
set /p input=overwrite? [y/n]:
if "%input%" == "y" goto init
if "%input%" == "n" goto complete
echo please check input and repeat.
goto input_loop

:init
for /f %%i in ('openssl rand -base64 32') do (
    echo= | set /p a=SETTINGS_ENCRYPTION_KEY=%%i> %SCRIPTS_RUNTIME_DIR%\duplicati.env
)
echo=>>%SCRIPTS_RUNTIME_DIR%\duplicati.env

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
