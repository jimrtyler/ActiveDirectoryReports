function Get-AllUsersReport {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ADServer,

        [Parameter(Mandatory = $true)]
        [string]$ADSearchBase
    )

    try {
        # Connect to the Active Directory server
        Import-Module ActiveDirectory
        Set-Location AD:

        # Query all users in the specified search base
        $users = Get-ADUser -Server $ADServer -SearchBase $ADSearchBase -Filter *

        if ($null -eq $users) {
            Write-Warning "No users found in the specified search base."
        } else {
            # Create a custom object for each user
            $userObjects = @()
            foreach ($user in $users) {
                $userObject = [PSCustomObject]@{
                    Name             = $user.Name
                    SamAccountName   = $user.SamAccountName
                    DistinguishedName= $user.DistinguishedName
                    Enabled          = $user.Enabled
                    # Add more properties as needed
                }
                $userObjects += $userObject
            }

            return $userObjects
        }
    } catch {
        Write-Error "An error occurred: $_"
    }
}

# Example usage:
# $allUsers = Get-AllUsersReport -ADServer "YourADServer" -ADSearchBase "OU=Users,DC=contoso,DC=com"
# $allUsers | Format-Table -AutoSize
