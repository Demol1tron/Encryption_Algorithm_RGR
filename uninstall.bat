@echo off
chcp 65001 >nul
echo Removing Encryption App...

set "APP_DIR=EncryptionApp"

if exist "%APP_DIR%" (
    echo Deleting program files...
    rmdir /s /q "%APP_DIR%"
    echo Encryption App successfully removed!
) else (
    echo Encryption App is not installed!
)

echo.
echo Removal complete!
pause