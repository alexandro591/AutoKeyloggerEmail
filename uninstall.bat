@echo off
cd /d %~dp0
rmdir /s /q "C:\ProgramData\theapp"
del "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\run.vbs"