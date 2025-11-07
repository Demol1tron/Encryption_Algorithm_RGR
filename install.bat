@echo off
chcp 65001 >nul
echo Starting installation...

g++ --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: g++ not found. Install MinGW!
    pause
    exit /b 1
)

set "APP_DIR=EncryptionApp"
mkdir "%APP_DIR%" 2>nul
mkdir "%APP_DIR%\dlls" 2>nul

echo Compiling libraries...
g++ -shared -o "%APP_DIR%\dlls\atbash.dll" ciphers\atbash.cpp
g++ -shared -o "%APP_DIR%\dlls\hill.dll" ciphers\hill.cpp
g++ -shared -o "%APP_DIR%\dlls\permutation.dll" ciphers\permutation.cpp

echo Compiling main program...
g++ -o "%APP_DIR%\EncryptionApp.exe" src\main.cpp utils\file_utils.cpp "%APP_DIR%\dlls\atbash.dll" "%APP_DIR%\dlls\hill.dll" "%APP_DIR%\dlls\permutation.dll"

if errorlevel 1 (
    echo COMPILATION FAILED!
    pause
    exit /b 1
)

echo Encryption App > "%APP_DIR%\README.txt"
echo. >> "%APP_DIR%\README.txt"
echo Algorithms: >> "%APP_DIR%\README.txt"
echo 1. Atbash - no key >> "%APP_DIR%\README.txt"
echo 2. Hill - 4 numbers key >> "%APP_DIR%\README.txt"
echo 3. Permutation - block cipher >> "%APP_DIR%\README.txt"

echo.
echo Installation complete!
dir "%APP_DIR%\"
pause