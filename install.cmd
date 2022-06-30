powershell -Command "Start-Process powershell -Verb RunAs -ArgumentList '& {Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force}'"
mkdir temp
mkdir data
mkdir data\emercoin
del .\path.ps1
set value='$desired_entry = \"%cd%\bin\"'
set MURZILLA='$murzilla = \"%cd%\"'
powershell -Command "Add-Content -Path .\path.ps1 -Value %value%"
powershell -Command "Add-Content -Path .\path.ps1 -Value %MURZILLA%"
powershell -Command "Add-Content -Path .\path.ps1 -Value (Get-Content '.\path.ps')"
powershell -Command "Start-Process powershell -Verb RunAs -ArgumentList '& powershell %CD%\path.ps1'"
.\bin\curl -L -o temp\ipfs.zip https://github.com/ipfs/go-ipfs/releases/download/v0.13.0/go-ipfs_v0.13.0_windows-amd64.zip
.\bin\7z.exe x -otemp temp\ipfs.zip
move temp\go-ipfs\ipfs.exe bin\ipfs.exe
del .\path.ps1
bin\ipfs.exe init --profile server
start bin\ipfs.exe daemon --enable-pubsub-experiment --enable-namesys-pubsub
timeout 5
copy .\start.cmd "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\murzilla.cmd"
For /f "tokens=1-3 delims=. " %%a in ('date /t') do (set mydate=%%c-%%b-%%a)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a:%%b)
echo %mydate%_%mytime% >> murzilla.log
bin\ipfs.exe id > temp\t.txt
find "ID" < temp\t.txt >> murzilla.log
bin\ipfs.exe name publish QmQPeNsJPyVWPFDVHb77w8G42Fvo15z4bG2X8D2GhfbSXc >> murzilla.log
rd /s /q temp
mkdir temp
timeout 9
shutdown /r
