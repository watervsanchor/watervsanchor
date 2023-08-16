# Check computer for uptime over 30 days. If true, send an email message reminder to apply updates and reboot.
# Author: Sam Smart

$computerName = $env:COMPUTERNAME
$uptime = (Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
$rebootDue= (Get-Date).AddDays(7).ToShortDateString()

#If system is up for 45+ days, Send email message via SMTP to desired addresses alerting that system needs a reboot
if ($uptime.TotalDays -gt 45) {
  $message = "The system $computerName has been up for $($uptime.TotalDays.ToString("0")) day(s) and has pending critical updates. Please reboot this system by $rebootDue so that updates can be applied. Thank you."
  Send-MailMessage -From "email" -To "email" -Cc "email" `
  -Subject "System Uptime Alert" -Body $message -SmtpServer 'ipaddress' -Priority High
}
#If system is up for 75+ days, start reboot timer of 72 hours and display warning on screen 
elseif ($uptime.TotalDays -gt 75) {
    shutdown -r -t 259200 -c " "
    [System.Windows.MessageBox]::Show('This system has been up beyond the maximum time allowed (75 days). Please save your work and reboot. This system will automatically reboot in 72 hours if a manual reboot is not performed.')
}
#If system is up for 80+ days, start reboot timer of 30 seconds and display warning on screen
elseif ($uptime.TotalDays -gt 80) {
	shutdown -r -t 30 -c " "
	[System.Windows.MessageBox]::Show('This system has reached the maximum uptime and will reboot in 30 seconds.')
}