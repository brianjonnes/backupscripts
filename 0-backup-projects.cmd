@echo off
rem setlocal enableextensions
setlocal enabledelayedexpansion

call check_disk.cmd
if errorlevel 1 echo "no backup disk found" && goto :end

:run2
choice /c DALFC /m "D - Remove deleted, A - Ignore extra files, L - Dry-run, F - Dry-run 2, C - Cancel:"
if %errorlevel% equ 1 ( set "rcopt=/mir /ndl" && goto :run3 )
if %errorlevel% equ 2 ( set "rcopt=/e /ndl" && goto :run3 )
if %errorlevel% equ 3 ( set "rcopt=/l /e /ndl" && goto :run3 )
if %errorlevel% equ 4 ( set "rcopt=/l /e" && goto :run3 )
echo No choice made.
goto :end

:run3
echo backing up to %w% on %MEDIA%

robocopy %rcopt% \\dns323\volume_1\projects %MEDIA%\dns323-projects
echo completed backing up to %w% on %MEDIA%

:end

pause
