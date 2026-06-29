@echo off
echo Starting Staff Leave Management System...
echo.

REM Try different Python commands
if exist "%LOCALAPPDATA%\Programs\Python\Python313\python.exe" (
    echo Installing Pillow if needed...
    "%LOCALAPPDATA%\Programs\Python\Python313\python.exe" -m pip install Pillow >nul 2>&1
    echo Running migrations...
    "%LOCALAPPDATA%\Programs\Python\Python313\python.exe" manage.py migrate
    echo Starting server...
    "%LOCALAPPDATA%\Programs\Python\Python313\python.exe" manage.py runserver
    goto :end
)
if exist "%LOCALAPPDATA%\Programs\Python\Python312\python.exe" (
    echo Installing Pillow if needed...
    "%LOCALAPPDATA%\Programs\Python\Python312\python.exe" -m pip install Pillow >nul 2>&1
    echo Running migrations...
    "%LOCALAPPDATA%\Programs\Python\Python312\python.exe" manage.py migrate
    echo Starting server...
    "%LOCALAPPDATA%\Programs\Python\Python312\python.exe" manage.py runserver
    goto :end
)
if exist "%LOCALAPPDATA%\Programs\Python\Python311\python.exe" (
    echo Installing Pillow if needed...
    "%LOCALAPPDATA%\Programs\Python\Python311\python.exe" -m pip install Pillow >nul 2>&1
    echo Running migrations...
    "%LOCALAPPDATA%\Programs\Python\Python311\python.exe" manage.py migrate
    echo Starting server...
    "%LOCALAPPDATA%\Programs\Python\Python311\python.exe" manage.py runserver
    goto :end
)

REM Try python command
python -m pip install Pillow >nul 2>&1
python manage.py migrate 2>nul
if %errorlevel% equ 0 (
    python manage.py runserver
    goto :end
)

REM Try py launcher
py -m pip install Pillow >nul 2>&1
py manage.py migrate 2>nul
if %errorlevel% equ 0 (
    py manage.py runserver
    goto :end
)

echo ERROR: Python not found. Please add Python to PATH.
pause
exit /b 1

:end
pause
