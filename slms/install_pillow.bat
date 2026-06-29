@echo off
echo Installing Pillow...
echo.

REM Try different Python commands
if exist "%LOCALAPPDATA%\Programs\Python\Python313\python.exe" (
    "%LOCALAPPDATA%\Programs\Python\Python313\python.exe" -m pip install Pillow
    goto :end
)
if exist "%LOCALAPPDATA%\Programs\Python\Python312\python.exe" (
    "%LOCALAPPDATA%\Programs\Python\Python312\python.exe" -m pip install Pillow
    goto :end
)
if exist "%LOCALAPPDATA%\Programs\Python\Python311\python.exe" (
    "%LOCALAPPDATA%\Programs\Python\Python311\python.exe" -m pip install Pillow
    goto :end
)

REM Try python command
python -m pip install Pillow 2>nul
if %errorlevel% equ 0 goto :end

REM Try py launcher
py -m pip install Pillow 2>nul
if %errorlevel% equ 0 goto :end

echo ERROR: Python not found. Please add Python to PATH.
pause
exit /b 1

:end
echo.
echo Pillow installed! Now run: python manage.py migrate
pause
