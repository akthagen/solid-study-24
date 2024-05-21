# Import Active Directory module
Import-Module ActiveDirectory

# Get the directory of the script
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

# Define the path to the CSV file
$csvFile = Join-Path -Path $scriptDir -ChildPath ".\fake payroll.csv"

# Set the base DN for the AD search
$baseDN = "DC=bogaland,DC=com"

# Function to check if a user exists in AD
function UserExistsInAD {
    param (
        [string]$username
    )
    $user = Get-ADUser -Filter {SamAccountName -eq $username} -ErrorAction SilentlyContinue
    if ($user) {
        return $true, $user
    } else {
        return $false, $null
    }
}

# Read the CSV file
$users = Import-Csv $csvFile

# Iterate over each user in the CSV file
foreach ($user in $users) {
    $username = $user.Username
    $email = $user.Email

    # Check if user exists in AD
    $exists, $adUser = UserExistsInAD -username $username

    if (-not $exists) {
        # Add user to AD
        $password = ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force  # Set the initial password here
        New-ADUser -SamAccountName $username -UserPrincipalName "$username@yourdomain.com" -Name $username -GivenName $username -Surname "User" -EmailAddress $email -AccountPassword $password -Enabled $true -Path $baseDN
        Write-Output "User $username added to AD."
    } else {
        # Remove user from AD if not in payroll
        if ($username -notin $users.Username) {
            Remove-ADUser -Identity $adUser -Confirm:$false
            Write-Output "User $username removed from AD."
        }
    }
}