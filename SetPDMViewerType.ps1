# Change Solidworks PDM license type to "Viewer" without requiring system reboot
# Author: Sam Smart

$RegistryPath = 'HKLM:\Software\SolidWorks\Applications\PDMWorks Enterprise\'
$Name = 'PTID'
$Value = '{CC72DD26-1A34-4209-B50B-21C7DD5E29F6}'
$PDMProcess = Get-Process EdmServer -ErrorAction SilentlyContinue
Set-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -Force

If ($EdmServer) {
    Write-Host "Stopping EdmServer..."
    Stop-Process -Name EdmServer -Force
    Write-Host "EdmServer has been stopped."
} else {
    Write-Host "EdmServer is not currently running."
}
    Stop-Process -Name explorer -Force