#Set desired timezone. Get available options using "Get-Timezone -ListAvailable"
$command = {Set-TimeZone -Id "Timezone"}
Invoke-Command -ComputerName computer -ScriptBlock $command
