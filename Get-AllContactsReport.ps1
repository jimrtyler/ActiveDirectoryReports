function Get-AllContactsReport {
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

        # Query all contact objects in the specified search base
        $contacts = Get-ADObject -Server $ADServer -SearchBase $ADSearchBase -LDAPFilter "(objectClass=contact)"

        if ($null -eq $contacts) {
            Write-Warning "No contact objects found in the specified search base."
        } else {
            # Create a custom object for each contact
            $contactObjects = @()
            foreach ($contact in $contacts) {
                $contactObject = [PSCustomObject]@{
                    Name             = $contact.Name
                    DisplayName      = $contact.DisplayName
                    DistinguishedName= $contact.DistinguishedName
                    
                }
                $contactObjects += $contactObject
            }

            return $contactObjects
        }
    } catch {
        Write-Error "An error occurred: $_"
    }
}

# Example usage:
# $allContacts = Get-AllContactsReport -ADServer "YourADServer" -ADSearchBase "OU=Contacts,DC=contoso,DC=com"
# $allContacts | Format-Table -AutoSize
