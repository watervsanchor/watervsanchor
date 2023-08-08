# Change Solidworks PDM license type to "Contributor" without requiring system reboot
# Author: Sam Smart

$RegistryPath = 'HKLM:\Software\SolidWorks\Applications\PDMWorks Enterprise\'
$Name = 'PTID'
$Value = '{E2BE88CF-6E17-43e2-A837-C1051F3E4EDB}'
$Process = Get-Process EdmServer -ErrorAction SilentlyContinue
Set-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -Force

If ($Process) {
    Write-Host "Stopping EdmServer..."
    Stop-Process -Name EdmServer -Force
    Write-Host "EdmServer has been stopped."
} else {
    Write-Host "EdmServer is not currently running."
}
    Stop-Process -Name explorer -Force
