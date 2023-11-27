function Get-TotalUserCount {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ADServer,

        [Parameter(Mandatory = $true)]
        [string]$ADDomain
    )

    try {
        # Connect to the Active Directory server
        Import-Module ActiveDirectory

        # Get the total user count in the specified domain
        $userCount = (Get-ADUser -Server $ADServer -Filter * -SearchBase "DC=$ADDomain").Count

        return $userCount
    } catch {
        Write-Error "An error occurred: $_"
    }
}

# Example usage:
# $userCount = Get-TotalUserCount -ADServer "YourADServer" -ADDomain "contoso.com"
# Write-Host "Total Users in the domain: $userCount"
