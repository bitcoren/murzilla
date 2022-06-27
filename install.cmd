powershell -Command "Start-Process powershell -Verb RunAs -ArgumentList '& {Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force}'"
set MURZILLA=%CD%
mkdir temp
del .\path.ps1
set value='$desired_entry = \"%cd%\bin\"'
echo %value%
powershell -Command "Add-Content -Path .\path.ps1 -Value %value%"
powershell -Command "Add-Content -Path .\path.ps1 -Value (Get-Content '.\path.ps')"
powershell -Command "Start-Process powershell -Verb RunAs -ArgumentList '& powershell %CD%\path.ps1'"
.\bin\curl -L -o temp\ipfs.zip https://github.com/ipfs/go-ipfs/releases/download/v0.13.0/go-ipfs_v0.13.0_windows-amd64.zip
.\bin\7z.exe x -otemp temp\ipfs.zip
move temp\go-ipfs\ipfs.exe bin\ipfs.exe
rd /s /q temp
mkdir temp
rm path.ps1
bin\ipfs.exe init --profile server
bin\ipfs.exe daemon --mount --enable-pubsub-experiment --enable-namesys-pubsub
copy .\start.cmd "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\murzilla.cmd"
