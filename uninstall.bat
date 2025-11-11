@echo off
chcp 65001 >nul
echo Removing Encryption_Algorithm_RGR...

set "APP_DIR=Encryption_Algorithm_RGR"

if exist "%APP_DIR%" (
    echo Deleting program files...
    rmdir /s /q "%APP_DIR%"
    echo Encryption_Algorithm_RGR successfully removed!
) else (
    echo Encryption_Algorithm_RGR is not installed!
)

echo.
echo Removal complete!
pause