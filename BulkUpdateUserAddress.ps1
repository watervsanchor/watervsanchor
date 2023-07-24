#Replaces Address tab with desired content for all users within designated OU

Get-ADUser -SearchBase "OU=Users,DC=domain,DC=com" -Filter * | Set-ADUser -StreetAddress "Street Address" -City "City" -State "State" -PostalCode "ZIP" -Country "Country"