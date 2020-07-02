@echo off
rem setlocal enableextensions
setlocal enabledelayedexpansion

call check_disk.cmd
if errorlevel 1 echo "no backup disk found" && goto :end

if "%COMPUTERNAME%" == "4720S-BRIAN" goto :4720s
echo computer "%COMPUTERNAME%" not valid
goto :end

:4720s

rem for %%m in (f g h) do (
rem 	if exist %%m:\media-name (
rem 		set MEDIA=%%m:
rem 		set /p w="" < %%m:\media-name
rem 		for /f %%n in (backup-media.txt) do (
rem 			if "%%n"=="!w!" goto :run2
rem 		)
rem 	)
rem )
rem echo "no disk found"
rem goto :end

rem :run2
echo backing up to %w% on %MEDIA%
if "%1" == "clean" ( set rcopt=/mir ) else ( set rcopt=/e )
robocopy %rcopt% c:\users\brian\documents %MEDIA%\hp4720s-documents /xf desktop.ini /xd brian-misc.git /xd not-backed-up from-usb-a projects share "My Music" "My Pictures" "My Videos" 
echo completed backing up to %w% on %MEDIA%

:end

pause
