@if not defined DEBUG echo off
call env.cmd
if ErrorLevel 1 goto failure

if exist %IMAGES_SAVE_DIR%\duplicati-%DUPLICATI_VERSION%.tar.gz (
    docker load -i %IMAGES_SAVE_DIR%\duplicati-%DUPLICATI_VERSION%.tar.gz
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
