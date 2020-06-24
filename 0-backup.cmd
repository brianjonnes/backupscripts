@echo off
rem setlocal enableextensions
setlocal enabledelayedexpansion

for %%m in (f g h) do (
	if exist %%m:\media-name (
		set MEDIA=%%m:
		set /p w="" < %%m:\media-name
		for %%n in (brian-usb-a brian-usb-b brian-usb-c brian-usb-d) do (
			if "%%n"=="!w!" goto :run2
		)
	)
)
echo "no disk found"
goto :end

:run2
echo backing up to %w% on %MEDIA%
robocopy /e c:\users\brian\documents %MEDIA%\from-hp4720s\documents /xd brian-misc.git /xd not-backed-up from-usb-a projects share "My Music" "My Pictures" "My Videos"
rem robocopy /e C:\Users\brian\AppData\Roaming\Thunderbird\Profiles %MEDIA%\from-hp4720s\thunderbird
echo completed backing up to %w% on %MEDIA%

:end

pause
