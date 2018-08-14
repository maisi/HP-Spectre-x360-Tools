@echo off

set localRwFolder=.local-rw-17

:: download rw if needed
if not exist %localRwFolder% (
    mkdir %localRwFolder%
    powershell -Command "Invoke-WebRequest -OutFile %localRwFolder%/rw-17.zip http://rweverything.com/downloads/RwPortableX64V1.7.zip"
    powershell -Command "Expand-Archive %localRwFolder%/*.zip -DestinationPath %localRwFolder%"
    del %localRwFolder%\rw-17.zip

    if %errorlevel% NEQ 0 exit /b
)
"%localRwFolder%/Win64/Portable/rw" /Command="%~dp0fanon.rw" /Stdout

