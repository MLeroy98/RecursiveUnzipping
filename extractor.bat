@echo off
setlocal enabledelayedexpansion

:extract_loop
set "extracted=0"
for /r %%i in (*.7z) do (
    set "folder=%%~dpi%%~ni"
    mkdir "!folder!" >nul 2>nul
    echo Extracting "%%i" to "!folder!"
    
    REM Run WinRAR in silent mode and suppress error messages
    "C:\Program Files\WinRAR\WinRAR.exe" x -ibck -inul -o+ -r "%%i" "!folder!" >nul 2>&1

    if errorlevel 1 (
        echo Error with "%%i" but continuing...
    ) else (
        del "%%i"
        set "extracted=1"
    )
)

if %extracted%==1 (
    echo Nested archives found, running again...
    goto extract_loop
) else (
    echo All extraction complete!
)

pause
