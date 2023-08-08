# Change Solidworks PDM license type to "CAD Editor" without requiring system reboot
# Author: Sam Smart

$RegistryPath = 'HKLM:\Software\SolidWorks\Applications\PDMWorks Enterprise\'
$Name = 'PTID'
$Value = '{05AD35C4-8A9A-4114-B51F-32186222ABA1}'
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