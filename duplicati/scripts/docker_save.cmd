@if not defined DEBUG echo off
call env.cmd
if ErrorLevel 1 goto failure

if not exist %IMAGES_SAVE_DIR% mkdir %IMAGES_SAVE_DIR%

if not exist %IMAGES_SAVE_DIR%\%2.tar.gz goto do_save

echo %IMAGES_SAVE_DIR%\%2.tar.gz exist!
dir /T:W %IMAGES_SAVE_DIR%\%2.tar.gz | find "tar.gz"
echo CurrentTime: %DATE%%TIME%
echo image history:
docker image history %1:%3 | wsl head -2

:input_loop
set input=
set /p input=overwrite? [y/n]:
if "%input%" == "y" goto do_save
if "%input%" == "n" goto complete
echo please check input and repeat.
goto input_loop

:: example.com/example/image example-image-latest latest
:: example.com/example/image example-image-example_tag latest
:do_save
echo save %1:%3 to %IMAGES_SAVE_DIR%\%2.tar.gz...
docker save %1:%3 | wsl gzip > %IMAGES_SAVE_DIR%\%2.tar.gz
if ErrorLevel 1 goto failure
echo save %1:%3 to %IMAGES_SAVE_DIR%\%2.tar.gz complete.

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
