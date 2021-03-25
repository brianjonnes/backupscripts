@echo off
rem Version 2 - https://killtheworld.co.za/backupscripts
setlocal enabledelayedexpansion

if "%1" == "CHECK" goto :check
if "%1" == "CHOICE" goto :choice
if "%1" == "PUBLISH" goto :publish
if "%1" == "DRIVE" goto :drive
if "%1" == "RO" goto :make_readonly
exit /b 1

:check
if not "%PUNINBLER%" == "" (
	for %%m in (%PUNINBLER%) do (
		if "%COMPUTERNAME%" == "%%m" goto :checka
	)
	echo:
	echo:Incorrect source punin'bler (%COMPUTERNAME%^)
	exit /b 1
)
:checka
if "%VALIDDRIVES%" == "" set VALIDDRIVES=d f g h
for %%m in (%VALIDDRIVES%) do (
	if exist %%m:\media-name (
		set MEDIA=%%m:
		set /p w="" < %%m:\media-name
		for %%n in (%VALIDMEDIA%) do (
			if "%%n"=="!w!" endlocal & set "BACKUPMEDIA=%%m:" & set "MEDIANAME=%%n" & goto :checkb
		)
	) else if exist %%m:\media-name.txt (
		set MEDIA=%%m:
		set /p w="" < %%m:\media-name.txt
		for %%n in (%VALIDMEDIA%) do (
			if "%%n"=="!w!" endlocal & set "BACKUPMEDIA=%%m:" & set "MEDIANAME=%%n" & goto :checkb
		)
	)
)
echo:
echo no backup disk found
exit /b 1
:checkb
echo:
echo Backing up to %MEDIANAME% on %BACKUPMEDIA%.
goto :eof

:choice
choice /c DALFC /m "D - Remove deleted, A - Ignore extra files, L - Dry-run, F - Dry-run 2, C - Cancel:"
if %errorlevel% equ 1 ( endlocal & set dryrun=0 & set "rcopt=/mir /ndl" && goto :eof )
if %errorlevel% equ 2 ( endlocal & set dryrun=0 & set "rcopt=/e /ndl" && goto :eof )
if %errorlevel% equ 3 ( endlocal & set dryrun=1 & set "rcopt=/l /e /ndl" && goto :eof )
if %errorlevel% equ 4 ( endlocal & set dryrun=1 set "rcopt=/l /e" && goto :eof )
echo:
echo No choice made.
exit /b 1

:drive
@if exist "%drive_conf%" (
  endlocal & set /p docdrive="" < "%drive_conf%" && goto :eof
)
endlocal & set "docdrive=%SYSTEMDRIVE:~0,1%" && goto :eof

:publish
set /p d="" < %source%\project_identifier
if "%d%"=="backupscripts" goto :two
echo "source directory not specified correctly"
pause 
goto :eof

:two
robocopy /fft /mir %source% %workdir%\backupscripts /xd .git /xf *.lnk
set /p f="" < %publishdir%\project_identifier
if "%f%"=="backupscripts" goto :four
echo "publish directory not specified correctly"
pause
goto :eof

:four
if exist %workdir%\backupscripts.old move %workdir%\backupscripts.old %workdir%\backupscripts.1
move %publishdir% %workdir%\backupscripts.old
move %workdir%\backupscripts %publishdir%
if exist %workdir%\backupscripts.1 move %workdir%\backupscripts.1 %workdir%\backupscripts
echo done
pause

:make_readonly
if "%dryrun%"=="1" goto :eof
attrib /s +r "%docdrive%:%dest%\*"
goto :eof
