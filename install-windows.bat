@echo off
setlocal enabledelayedexpansion

:: LiveCut Windows Build and Install Script

echo [INFO] Starting LiveCut plugin build and install script.

:: Check current directory
if not exist "Makefile-windows" (
    echo [ERROR] Please run this script from the LiveCut repository root directory.
    exit /b 1
)

:: Start building
echo [INFO] Building LiveCut plugins...
mingw32-make -f Makefile-windows clean && mingw32-make -f Makefile-windows
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Build failed. Please check for errors.
    exit /b 1
)
echo [SUCCESS] Build completed successfully.

:: Define plugin directories
set "VST2_DIR=%HOMEDRIVE%%HOMEPATH%\Documents\VST Plugins"
set "VST3_DIR=%COMMONPROGRAMFILES%\VST3"
set "CLAP_DIR=%COMMONPROGRAMFILES%\CLAP"
set "LV2_DIR=%HOMEDRIVE%%HOMEPATH%\Documents\LV2"

:: Create plugin folders
echo [INFO] Creating plugin directories...
if not exist "%VST2_DIR%" (
    mkdir "%VST2_DIR%"
    echo [INFO] Created directory %VST2_DIR%.
) else (
    echo [INFO] Directory %VST2_DIR% already exists.
)

if not exist "%VST3_DIR%" (
    mkdir "%VST3_DIR%"
    echo [INFO] Created directory %VST3_DIR%.
) else (
    echo [INFO] Directory %VST3_DIR% already exists.
)

if not exist "%CLAP_DIR%" (
    mkdir "%CLAP_DIR%"
    echo [INFO] Created directory %CLAP_DIR%.
) else (
    echo [INFO] Directory %CLAP_DIR% already exists.
)

if not exist "%LV2_DIR%" (
    mkdir "%LV2_DIR%"
    echo [INFO] Created directory %LV2_DIR%.
) else (
    echo [INFO] Directory %LV2_DIR% already exists.
)

:: Start plugin installation
echo [INFO] Starting plugin installation...

:: Install VST2 plugin
set "VST2_SRC=bin\LiveCut.dll"
set "VST2_DEST=%VST2_DIR%\LiveCut.dll"
set vst2_result=0

if exist "%VST2_SRC%" (
    copy /Y "%VST2_SRC%" "%VST2_DEST%" > nul
    echo [INFO] Copied LiveCut.dll to %VST2_DIR%.
    echo [SUCCESS] VST2 plugin installation completed.
) else (
    echo [ERROR] VST2 plugin does not exist.
    set vst2_result=1
)

:: Install VST3 plugin
set "VST3_SRC=bin\LiveCut.vst3"
set "VST3_DEST=%VST3_DIR%\LiveCut.vst3"
set vst3_result=0

if exist "%VST3_SRC%" (
    if exist "%VST3_DEST%" rmdir /S /Q "%VST3_DEST%"
    xcopy /E /I /Y "%VST3_SRC%" "%VST3_DEST%" > nul
    echo [INFO] Copied LiveCut.vst3 to %VST3_DIR%.
    echo [SUCCESS] VST3 plugin installation completed.
) else (
    echo [ERROR] VST3 plugin does not exist.
    set vst3_result=1
)

:: Install CLAP plugin
set "CLAP_SRC=bin\LiveCut.clap"
set "CLAP_DEST=%CLAP_DIR%\LiveCut.clap"
set clap_result=0

if exist "%CLAP_SRC%" (
    if exist "%CLAP_DEST%" rmdir /S /Q "%CLAP_DEST%"
    xcopy /E /I /Y "%CLAP_SRC%" "%CLAP_DEST%" > nul
    echo [INFO] Copied LiveCut.clap to %CLAP_DIR%.
    echo [SUCCESS] CLAP plugin installation completed.
) else (
    echo [ERROR] CLAP plugin does not exist.
    set clap_result=1
)

:: Install LV2 plugin
set "LV2_SRC=bin\LiveCut.lv2"
set "LV2_DEST=%LV2_DIR%\LiveCut.lv2"
set lv2_result=0

if exist "%LV2_SRC%" (
    if exist "%LV2_DEST%" rmdir /S /Q "%LV2_DEST%"
    xcopy /E /I /Y "%LV2_SRC%" "%LV2_DEST%" > nul
    echo [INFO] Copied LiveCut.lv2 to %LV2_DIR%.
    echo [SUCCESS] LV2 plugin installation completed.
) else (
    echo [ERROR] LV2 plugin does not exist.
    set lv2_result=1
)

:: Installation summary
echo.
echo [INFO] ====== Installation Summary ======
if %vst2_result% equ 0 (
    echo [SUCCESS] VST2: Installation completed (%VST2_DEST%)
) else (
    echo [ERROR] VST2: Installation failed
)

if %vst3_result% equ 0 (
    echo [SUCCESS] VST3: Installation completed (%VST3_DEST%)
) else (
    echo [ERROR] VST3: Installation failed
)

if %clap_result% equ 0 (
    echo [SUCCESS] CLAP: Installation completed (%CLAP_DEST%)
) else (
    echo [ERROR] CLAP: Installation failed
)

if %lv2_result% equ 0 (
    echo [SUCCESS] LV2: Installation completed (%LV2_DEST%)
) else (
    echo [ERROR] LV2: Installation failed
)

echo.
echo [INFO] ===== DAW Rescan Required =====
echo [WARNING] Please restart your DAW or run plugin rescan to recognize the newly installed plugins.

echo.
echo [SUCCESS] Plugin installation script completed successfully!

pause 