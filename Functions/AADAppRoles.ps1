#
# AADAppRoles.ps1
#
function Set-UserAppRole {
Param(
    [parameter(Mandatory=$true,
    ParameterSetName="Roles",
	HelpMessage="Enter one or more Roles separated by commas.")]
    [String[]]
    $Roles,

    [parameter(Mandatory=$true,
    ParameterSetName="User",
	HelpMessage="Enter Username as that is Listed as Displayed")]
    [String[]]
    $UserName,
	
	[parameter(Mandatory=$true,
    ParameterSetName="App Name",
	HelpMessage="Enter App Name")]
    [String[]]
    $app_name
)

	foreach ($r in $roles){

# Get the user to assign, and the service principal for the app to assign to

	$user = Get-AzureADUser -SearchString $username
	$sp = Get-AzureADServicePrincipal -Filter "displayName eq '$app_name'"
	$appRole = $sp.AppRoles | Where-Object { $_.DisplayName -eq $r }

#Assign the user to the app role

	New-AzureADUserAppRoleAssignment -ObjectId $user.ObjectId -PrincipalId $user.ObjectId -ResourceId $sp.ObjectId -Id $appRole.Id

}

}