@echo off
set "target_dir=c:\Users\Server\AppData\Roaming\Changemaker Studios\Papercut SMTP\"
set interval_seconds=5
:smtp_daemon
cls
echo testing
touch C:\Walls\tmp\baseline.log
touch C:\Walls\tmp\snapshot.log

dir /b "%target_dir%"	> C:\Walls\tmp\baseline.log
timeout /t 5 >nul /nobreak	
dir /b "%target_dir%"	 > C:\Walls\tmp\snapshot.log
FC /L /N "C:\Walls\tmp\baseline.log" "C:\Walls\tmp\snapshot.log"
	if errorlevel 1 (
		goto :generate_html
	) else (
		goto :update_baseline_snapshot
	)
:generate_html
echo ^<html^> > "C:\DNSd\www\mail\index.html"
echo ^<head^> >> "C:\DNSd\www\mail\index.html"
echo ^<title^>EML File List^</title^> >> "C:\DNSd\www\mail\index.html"
echo ^<style^> >> "C:\DNSd\www\mail\index.html"
echo body { font-family: sans-serif; } >> "C:\DNSd\www\mail\index.html"
echo table { border-collapse: collapse; width: 80%%; margin: 20px auto; } >> "C:\DNSd\www\mail\index.html"
echo th, td { border: 1px solid #ccc; padding: 8px; text-align: left; } >> "C:\DNSd\www\mail\index.html"
echo th { background-color: #f2f2f2; } >> "C:\DNSd\www\mail\index.html"
echo ^</style^> >> "C:\DNSd\www\mail\index.html"
echo ^</head^> >> "C:\DNSd\www\mail\index.html"
echo ^<body^> >> "C:\DNSd\www\mail\index.html"
echo ^<h1^>List of EML Files^</h1^> >> "C:\DNSd\www\mail\index.html"
echo ^<table^> >> "C:\DNSd\www\mail\index.html"
echo ^<tr^>^<th^>File Name^</th^>^<th^>Subject^</th^>^<th^>From^</th^>^</tr^> >> "C:\DNSd\www\mail\index.html"

for %%f in ("%target_dir%\*.eml") do (
	set "filename=%%~nxf"
	echo "%%~nxf"
    echo %filename%
    type "%filename%" > "C:\DNSd\www\mail\files\%filename%.html"
    echo ^<tr^>^<td^>^<a href="/mail/files/%filename%.html"^>%filename%^</a^>^</td^>^</tr^> >> "C:\DNSd\www\mail\index.html"
)
echo ^</table^> >> "C:\DNSd\www\mail\index.html"
echo ^</body^> >> "C:\DNSd\www\mail\index.html"
echo ^</html^> >> "C:\DNSd\www\mail\index.html"


:update_baseline_snapshot
		copy "C:\Walls\tmp\snapshot.log" "C:\Walls\tmp\baseline.log" > nul
	)
	goto :smtp_daemon









goto :eof
:daemon
cls
:snapshot
	echo scanning smtp @ mail.rslvd.net
	pushd "%target_dir%"
	DIR /S /A /B > "%temp%\current_snapshot.txt"
	popd
:baseline_control
	FC /L /N "%baseline_file%" "%temp%\current_snapshot.txt" > nul
	if errorlevel 1 (
		echo Changes detected in %target_dir% at %date% %time% >> "%log_file%"
		echo Differences: >> "%log_file%"
		FC /L /N "%baseline_file%" "%temp%\current_snapshot.txt" >> "%log_file%"
		echo. >> "%log_file%"
:update_baseline_snapshot
		copy "%temp%\current_snapshot.txt" "%baseline_file%" > nul
	)
:sleep
timeout /t %interval_seconds% > nul
goto :daemon

:eof