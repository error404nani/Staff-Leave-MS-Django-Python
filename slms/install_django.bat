@echo off
echo Installing Django and Pillow...
echo.

if exist "%LOCALAPPDATA%\Programs\Python\Python313\python.exe" (
    set PYTHON=%LOCALAPPDATA%\Programs\Python\Python313\python.exe
) else if exist "%LOCALAPPDATA%\Programs\Python\Python312\python.exe" (
    set PYTHON=%LOCALAPPDATA%\Programs\Python\Python312\python.exe
) else if exist "%LOCALAPPDATA%\Programs\Python\Python311\python.exe" (
    set PYTHON=%LOCALAPPDATA%\Programs\Python\Python311\python.exe
) else (
    set PYTHON=python
)

%PYTHON% --version 2>nul
if %errorlevel% neq 0 (
    echo Python not found. Add Python to PATH or run from Python install folder.
    pause
    exit /b 1
)

%PYTHON% -m pip install Django==4.2 Pillow
if %errorlevel% neq 0 (
    echo Django 4.2 may not support your Python. Trying latest Django...
    %PYTHON% -m pip install Django Pillow
)

echo.
echo Done! To run: cd slms ^&^& python manage.py runserver
pause
