@echo off
chcp 65001 >nul
echo Установка Encryption App...

g++ --version >nul 2>&1
if errorlevel 1 (
    echo Ошибка: g++ не найден. Установите MinGW!
    pause
    exit /b 1
)

:: Создание структуры папок
set "APP_DIR=EncryptionApp"
mkdir "%APP_DIR%" 2>nul
mkdir "%APP_DIR%\dlls" 2>nul

echo Компиляция библиотек...
echo 1) Атбаш...
g++ -shared -o "%APP_DIR%\dlls\atbash.dll" ciphers\atbash.cpp

echo 2) Шифр Хилла...
g++ -shared -o "%APP_DIR%\dlls\hill.dll" ciphers\hill.cpp

echo 3) Шифр фиксированной перестановки...
g++ -shared -o "%APP_DIR%\dlls\permutation.dll" ciphers\permutation.cpp

echo Компиляция программы...
g++ -o "%APP_DIR%\EncryptionApp.exe" src\main.cpp utils\file_utils.cpp -L"%APP_DIR%\dlls" -latbash -lhill -lpermutation

if errorlevel 1 (
    echo Ошибка компиляции!
    pause
    exit /b 1
)

(
echo Encryption App - программа для шифрования и дешифрования текстов 
echo и файлов с использованием трех алгоритмов:
echo.
echo 1. Атбаш
echo     - простая замена символов;
echo     - не требует ключа;
echo.
echo 2. Шифр Хилла
echo    - матричное шифрование;
echo    - ключ: 4 числа через запятую (например: 1,3,5,7);
echo    - определитель матрицы должен быть нечетным.
echo.
echo 3. Шифр фиксированной перестановки
echo    - юлочная перестановка символов;
echo    - ключ: перестановка чисел 1-4 (например: 3,2,4,1);
echo    - размер блока: 4 символа.
echo.
echo Запуск программы происходит через ярлык на рабочем столе.
) > "%APP_DIR%\README.txt"

echo.
echo Установка завершена!
echo.
dir "%APP_DIR%\dlls"
echo.
pause