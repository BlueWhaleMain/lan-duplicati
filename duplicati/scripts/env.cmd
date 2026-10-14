@if not defined DEBUG echo off
for /f %%i in ('dir /b *.env') do (
    for /f "eol=# delims=" %%j in (%%i) do set %%j
)

if not exist %HOME_DIR% mkdir %HOME_DIR%
if ErrorLevel 1 goto failure

echo loading runtime environments file: %HOME_DIR%\*.env ...
for /f %%i in ('dir /b %HOME_DIR%\*.env') do (
    for /f "eol=# delims=" %%j in (%HOME_DIR%\%%i) do set %%j
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
