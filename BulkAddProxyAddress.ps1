Import-Module ActiveDirectory

#Set desired proxy domain
$proxyDomain = "@domain.com"
#Set desired target OU
$ou = 'OU=Users,DC=domain,DC=com'
$users = Get-ADUser -Filter * -SearchBase $ou -Properties SamAccountName, ProxyAddresses 

#Create smtp proxyAddress using firstname.lastname@domain.com
Foreach ($user in $users) {
    Set-ADUser -Identity $user.samaccountname -Add @{proxyAddresses="smtp:"+$user.samaccountname+$proxyDomain}
    } 