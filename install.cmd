powershell -Command "Start-Process powershell -Verb RunAs -ArgumentList '& {Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force}'"
mkdir temp
mkdir data
mkdir data\ipfs
set IPFS_PATH=%cd%\data\ipfs
del .\path.ps1
set value='$desired_entry = \"%cd%\bin\"'
set MURZILLA='$murzilla = \"%cd%\"'
set IPFSPATH='$ipfspath = \"%cd%\data\ipfs\"'
powershell -Command "Add-Content -Path .\path.ps1 -Value %value%"
powershell -Command "Add-Content -Path .\path.ps1 -Value %MURZILLA%"
powershell -Command "Add-Content -Path .\path.ps1 -Value %IPFSPATH%"
powershell -Command "Add-Content -Path .\path.ps1 -Value (Get-Content '.\path.ps')"
powershell -Command "Start-Process powershell -Verb RunAs -ArgumentList '& powershell %CD%\path.ps1'"
bin\curl -L -o temp\kubo.zip https://github.com/ipfs/kubo/releases/download/v0.14.0/kubo_v0.14.0_windows-amd64.zip
bin\7z.exe x -otemp temp\kubo.zip
move temp\kubo\ipfs.exe bin\ipfs.exe
del .\path.ps1
bin\ipfs.exe init --profile server
start bin\ipfs.exe daemon --enable-pubsub-experiment --enable-namesys-pubsub
timeout 5
bin\ipfs config --json Experimental.FilestoreEnabled true
mkdir bin\murzillagui
bin\curl -L -o temp\murzillagui.zip https://github.com/bitcoren/murzillagui/releases/download/v0.0.2/murzilla-0.0.2-win.zip
bin\7z.exe x -obin\murzillagui temp\murzillagui.zip
bin\curl -L -o temp\zeronet.zip https://github.com/ZeroNetX/ZeroNet/releases/download/v0.8.0/ZeroNet-win.zip
bin\7z.exe x temp\zeronet.zip
copy bin\zeronet.conf ZeroNet-win\zeronet.conf
start ZeroNet-win\ZeroNet.exe
copy start.cmd "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\murzilla.cmd"
copy once.cmd "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\once.cmd"
For /f "tokens=1-3 delims=. " %%a in ('date /t') do (set mydate=%%c-%%b-%%a)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a:%%b)
echo %mydate%_%mytime% >> murzilla.log
bin\ipfs.exe id > temp\t.txt
find "ID" < temp\t.txt >> murzilla.log
bin\ipfs.exe name publish QmQPeNsJPyVWPFDVHb77w8G42Fvo15z4bG2X8D2GhfbSXc >> murzilla.log
start bin\murzillagui\murzilla.exe
bin\curl -L -o temp\python.exe https://www.python.org/ftp/python/3.10.5/python-3.10.5-amd64.exe
temp\python.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
bin\curl -L -o temp\node.msi https://nodejs.org/dist/v16.15.1/node-v16.15.1-x64.msi
temp\node.msi
rd /s /q temp
mkdir temp
timeout 9
shutdown /r
