$command = { Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol}
Invoke-Command -ComputerName Computer -ScriptBlock $command