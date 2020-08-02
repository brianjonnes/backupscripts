@echo off
rem setlocal enableextensions
setlocal enabledelayedexpansion

call check_disk.cmd
if errorlevel 1 echo "no backup disk found" && goto :end

if "%COMPUTERNAME%" == "4720S-BRIAN" goto :4720s
echo computer "%COMPUTERNAME%" not valid
goto :end

:4720s
choice /c DALC /m "D - Remove deleted, A - Ignore extra files, L - Dry-run, C - Cancel:"
if %errorlevel% equ 1 ( set rcopt=/mir && goto :run3 )
if %errorlevel% equ 2 ( set rcopt=/e && goto :run3 )
if %errorlevel% equ 3 ( set "rcopt=/l /e" && goto :run3 )
echo No choice made.
goto :end

:run3
echo backing up to %w% on %MEDIA%
rem if "%1" == "clean" ( set rcopt=/mir ) else ( set rcopt=/e )
robocopy %rcopt% c:\users\brian\documents %MEDIA%\hp4720s-documents /xf desktop.ini /xd not-backed-up "My Music" "My Pictures" "My Videos" 
echo completed backing up to %w% on %MEDIA%

:end

pause
