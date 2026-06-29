@echo off
echo ========================================
echo Staff Leave Management System - Setup
echo ========================================
echo.

REM Try python, then py, then full path
set PYTHON=
where python >nul 2>&1
if %errorlevel% equ 0 (
    set PYTHON=python
    goto :found
)
where py >nul 2>&1
if %errorlevel% equ 0 (
    set PYTHON=py -3
    goto :found
)
if exist "C:\Users\kasuk\AppData\Local\Programs\Python\Python313\python.exe" (
    set PYTHON=C:\Users\kasuk\AppData\Local\Programs\Python\Python313\python.exe
    goto :found
)
if exist "%LOCALAPPDATA%\Programs\Python\Python313\python.exe" (
    set PYTHON=%LOCALAPPDATA%\Programs\Python\Python313\python.exe
    goto :found
)
echo ERROR: Python not found. Please add Python to PATH.
pause
exit /b 1

:found
echo Using: %PYTHON%
%PYTHON% --version
echo.

echo [1/4] Installing Django and Pillow...
%PYTHON% -m pip install Django==4.2 Pillow
if %errorlevel% neq 0 (
    echo.
    echo Django 4.2 may not support your Python version. Trying latest Django...
    %PYTHON% -m pip install Django Pillow
)
if %errorlevel% neq 0 (
    echo ERROR: Failed to install Django.
    pause
    exit /b 1
)
echo.

echo [2/4] Running migrations...
cd /d "%~dp0"
%PYTHON% manage.py migrate
if %errorlevel% neq 0 (
    echo ERROR: Migrations failed.
    pause
    exit /b 1
)
echo.

echo [3/4] Checking for superuser...
%PYTHON% manage.py shell -c "from django.contrib.auth import get_user_model; User=get_user_model(); print('OK' if User.objects.filter(is_superuser=True).exists() else 'NONE')" 2>nul | find "NONE" >nul
if %errorlevel% equ 0 (
    echo No admin user found. Creating superuser...
    %PYTHON% manage.py createsuperuser
) else (
    echo Superuser exists. Skipping.
)
echo.

echo [4/4] Starting development server...
echo.
echo ========================================
echo Open http://127.0.0.1:8000/ in browser
echo Press CTRL+C to stop the server
echo ========================================
echo.
%PYTHON% manage.py runserver
pause
