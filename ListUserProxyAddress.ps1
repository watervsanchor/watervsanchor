#List all proxyAddress for users in target OU
get-aduser -filter * -SearchBase "OU=Users,DC=domain,DC=com" -Properties ProxyAddresses | select Name, ProxyAddresses