@echo off
rem setlocal enableextensions
setlocal enabledelayedexpansion

call check_disk.cmd
if errorlevel 1 echo "no backup disk found" && goto :end

rem for %%m in (f g h) do (
rem 	if exist %%m:\media-name (
rem 		set MEDIA=%%m:
rem 		set /p w="" < %%m:\media-name
rem 		for %%n in (brian-usb-a brian-usb-b brian-usb-c brian-usb-f) do (
rem 			if "%%n"=="!w!" goto :run2
rem 		)
rem 	)
rem )
rem echo "no disk found"
rem goto :end

:run2
echo backing up to %w% on %MEDIA%
if "%1" == "clean" ( set rcopt=/mir ) else ( set rcopt=/e )
robocopy %rcopt% C:\Users\brian\AppData\Roaming\Thunderbird\Profiles %MEDIA%\hp4720s-thunderbird
echo completed backing up email to %w% on %MEDIA%

:end

pause
