@echo off

setlocal enableDelayedExpansion

set downloadFolder=%userprofile%\Pictures\Assets
set assetsFolder=%userprofile%\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets\
set files=*.*

if not exist "%downloadFolder%temp\" (
    mkdir "%downloadFolder%temp\"
)

del /q "%downloadFolder%temp\%files%"

copy "%assetsFolder%%files%" "%downloadFolder%temp\%files%" >nul

%downloadFolder:~0,2%
cd "%downloadFolder%temp\"

rename *.* *.jpg

for /r %%a in (*.jpg *.bmp *.png) do (
    for /f "tokens=1-2" %%i in ('magick identify -ping -format "%%w %%h" "%%a"') do (
        set /a R=%%i*%%j
        if !R! lss 1000000 (
            del "%%a"
        )
    )
)

move "%downloadFolder%temp\*" "%downloadFolder%" >nul

echo Finished copying recent Assets
timeout /t 5

REM set "width="
REM set "height="
REM for /f "tokens=1*delims=:" %%b in ('"MEDIAINFO --INFORM=Image;%%Width%%:%%Height%% "%%~a""') do (
REM     echo(%%~a 1 1 1 %%~b %%~c
REM )