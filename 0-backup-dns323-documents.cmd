@echo off
rem setlocal enableextensions
setlocal enabledelayedexpansion

call check_disk.cmd
if errorlevel 1 echo "no backup disk found" && goto :end

:run2
echo backing up to %w% on %MEDIA%
if "%1" == "clean" ( set rcopt=/mir ) else ( set rcopt=/e )

robocopy %rcopt% \\dns323\volume_1\documents %MEDIA%\dns323-documents
echo completed backing up to %w% on %MEDIA%

:end

pause
