#1. Step 1 - Install PnP Powershell module
Install-Module -Name PnP.PowerShell

#2. Step 2 - Register PnP App in Azure
Register-PnPAzureADApp -ApplicationName "PnP PowerShell" -Tenant [yourtenant].onmicrosoft.[com][us] -Interactive -AzureEnvironment [USGovernment][USGovernmentHigh] -SharePointDelegatePermissions AllSites.FullControl -SharePointApplicationPermissions Sites.FullControl.All -GraphApplicationPermissions Group.ReadWrite.All -GraphDelegatePermissions Group.ReadWrite.All

#3. Step 3 - Run collection script

#Parameters. ListName is referencing Document Library name.
$SiteUrl = "https://[yourtenant].sharepoint.[com][us]/sites/[yoursharepointsite]"
$ReportOutput = "C:\Temp\SharedLinks.csv"
$ListName = "Documents"


#Connect to PnP Online
Connect-PnPOnline -Url $SiteURL -Interactive -ClientId [yourpnpappid] -Tenant [yourtenant] -AzureEnvironment USGovernment[High]
$Ctx = Get-PnPContext
$Results = @()
$global:counter = 0

#Get all list items in batches
$ListItems = Get-PnPListItem -List $ListName -PageSize 2000
$ItemCount = $ListItems.Count

#Iterate through each list item
ForEach($Item in $ListItems)
{
Write-Progress -PercentComplete ($global:Counter / ($ItemCount) * 100) -Activity "Getting Shared Links from '$($Item.FieldValues["FileRef"])'" -Status "Processing Items $global:Counter to $($ItemCount)";



#Get Shared Links
$SharingInfo = [Microsoft.SharePoint.Client.ObjectSharingInformation]::GetObjectSharingInformation($Ctx, $Item, $false, $false, $false, $true, $true, $true, $true)
$ctx.Load($SharingInfo)
$ctx.ExecuteQuery()

ForEach($ShareLink in $SharingInfo.SharingLinks)
{
If($ShareLink.Url)
{
If($ShareLink.IsEditLink)
{
$AccessType="Edit"
}
ElseIf($shareLink.IsReviewLink)
{
$AccessType="Review"
}
Else
{
$AccessType="ViewOnly"
}

#Collect the data
$Results += New-Object PSObject -property $([ordered]@{
Name = $Item.FieldValues["FileLeafRef"]
RelativeURL = $Item.FieldValues["FileRef"]
FileType = $Item.FieldValues["File_x0020_Type"]
ShareLink = $ShareLink.Url
ShareLinkAccess = $AccessType
ShareLinkType = $ShareLink.LinkKind
AllowsAnonymousAccess = $ShareLink.AllowsAnonymousAccess
IsActive = $ShareLink.IsActive
Expiration = $ShareLink.Expiration
})
}
}

$global:counter++
}
$Results | Export-CSV $ReportOutput -NoTypeInformation
Write-host -f Green "Sharing Links Report Generated Successfully!"
