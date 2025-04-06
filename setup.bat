@echo off
setlocal enabledelayedexpansion

echo ====== n8n Setup Script for Windows ======
echo This script will help you set up n8n for local development.
echo.

REM Check for Node.js
echo Checking Node.js installation...
where node >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    for /f "tokens=*" %%i in ('node -v') do set NODE_VERSION=%%i
    echo ✅ Node.js is installed: !NODE_VERSION!
    
    REM Extract major version number
    set NODE_MAJOR=!NODE_VERSION:~1,2!
    
    if !NODE_MAJOR! LSS 20 (
        echo ❌ Node.js version is less than 20.15. Please update Node.js.
        echo   You can download a newer version from: https://nodejs.org/
        exit /b 1
    )
) else (
    echo ❌ Node.js is not installed. Please install Node.js 20.15 or newer.
    echo   Download from: https://nodejs.org/
    exit /b 1
)

REM Check for pnpm
echo Checking pnpm installation...
where pnpm >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    for /f "tokens=*" %%i in ('pnpm -v') do set PNPM_VERSION=%%i
    echo ✅ pnpm is installed: !PNPM_VERSION!
) else (
    echo pnpm is not installed. Would you like to install it? (y/n)
    set /p INSTALL_PNPM=
    if /i "!INSTALL_PNPM!"=="y" (
        echo Installing pnpm using corepack...
        corepack enable
        corepack prepare pnpm@latest --activate
        if %ERRORLEVEL% EQU 0 (
            echo ✅ pnpm installed successfully
        ) else (
            echo ❌ Failed to install pnpm. Please install it manually.
            exit /b 1
        )
    ) else (
        echo ❌ pnpm is required for n8n development. Please install it manually.
        exit /b 1
    )
)

REM Check for build tools
echo Checking build tools...
echo If you encounter build errors later, you may need to install Windows build tools.
echo Run as Administrator: npm add -g windows-build-tools
echo.

REM Install dependencies
echo Installing n8n dependencies...
call pnpm install
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Error installing dependencies.
    exit /b 1
) else (
    echo ✅ Dependencies installed successfully
)

REM Build the project
echo.
echo Building n8n...
call pnpm build
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Error building n8n.
    exit /b 1
) else (
    echo ✅ n8n built successfully
)

echo.
echo ====== Setup Complete! ======
echo.
echo You can now start n8n in development mode with:
echo pnpm dev
echo.
echo Access the editor at: http://localhost:5678
echo.
echo For more information, see the SETUP_GUIDE.md file.
echo.

endlocal
