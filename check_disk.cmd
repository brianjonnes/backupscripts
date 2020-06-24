
for %%m in (f g h) do (
	if exist %%m:\media-name (
		set MEDIA=%%m:
		set /p w="" < %%m:\media-name
		for /f %%n in (backup-disks.txt) do (
			if "%%n"=="!w!" goto :run2
		)
	)
)

exit /b 1

:run2