function Get-UserCountInOU {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ADServer,

        [Parameter(Mandatory = $true)]
        [string]$OUPath
    )

    try {
        # Connect to the Active Directory server
        Import-Module ActiveDirectory

        # Get the total user count in the specified OU
        $userCount = (Get-ADUser -Server $ADServer -Filter * -SearchBase $OUPath).Count

        return $userCount
    } catch {
        Write-Error "An error occurred: $_"
    }
}

# Example usage:
# $ouPath = "OU=Sales,OU=Users,DC=contoso,DC=com"
# $userCount = Get-UserCountInOU -ADServer "YourADServer" -OUPath $ouPath
# Write-Host "Total Users in $ouPath: $userCount"
