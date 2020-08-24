set workdir=\\dns323\volume_1\documents\.publish
set publishdir=\\dns323\volume_1\documents\backupscripts
set source=%1
set /p d="" < %1\project_identifier
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