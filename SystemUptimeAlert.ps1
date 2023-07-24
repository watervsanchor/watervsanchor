# Check computer for uptime over 30 days. If true, send an email message reminder to apply updates and reboot.
# Author: Sam Smart

$computerName = $env:COMPUTERNAME
$uptime = (Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
$rebootDue= (Get-Date).AddDays(7).ToShortDateString()

if ($uptime.TotalDays -gt 60) {
  $message = "The analysis system $computerName has been up for $($uptime.TotalDays.ToString("0")) day(s) and has pending critical updates. Please reboot this system by $rebootDue so that updates can be applied. Thank you."
  Send-MailMessage -From "italerts@custommicrowave.com" -To "email" -Cc "email" `
  -Subject "Analysis System Uptime Alert" -Body $message -SmtpServer '10.0.10.18' -Priority High
}