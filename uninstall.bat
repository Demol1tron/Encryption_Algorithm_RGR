@echo off
chcp 65001 >nul
echo Удаление Encryption App...

set "APP_DIR=EncryptionApp"

if exist "%APP_DIR%" (
    echo Удаление папки программы...
    rmdir /s /q "%APP_DIR%"
    echo Папка "%APP_DIR%" удалена
) else (
    echo Папка "%APP_DIR%" не найдена
)

echo.
echo Удаление завершено!
pause