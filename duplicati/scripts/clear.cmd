@if not defined DEBUG echo off
call env.cmd
if ErrorLevel 1 goto failure

echo remove these files:
docker compose exec duplicati ls -l /tmp | more

:input_loop
set input=
set /p input=continue? [y/n]:
if "%input%" == "y" goto do_clear
if "%input%" == "n" goto complete
echo please check input and repeat.
goto input_loop

:do_clear
docker compose ps | wsl grep -w duplicati
if ErrorLevel 0 (
    set restart=1
    docker compose stop
)

docker compose --profile cleanup run --rm cleaner
if ErrorLevel 1 goto failure
if defined restart docker compose start

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
