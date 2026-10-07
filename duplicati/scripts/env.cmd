@if not defined DEBUG echo off
for /f %%i in ('dir /b *.env') do (
    for /f "eol=# delims=" %%j in (%%i) do set %%j
)

if not exist %SCRIPTS_RUNTIME_DIR% mkdir %SCRIPTS_RUNTIME_DIR%
if ErrorLevel 1 goto failure

echo loading runtime environments file: %SCRIPTS_RUNTIME_DIR%\*.env ...
for /f %%i in ('dir /b %SCRIPTS_RUNTIME_DIR%\*.env') do (
    for /f "eol=# delims=" %%j in (%SCRIPTS_RUNTIME_DIR%\%%i) do set %%j
)

set PATH=%PATH%;"%OPENSSL_PATH%\bin"
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
