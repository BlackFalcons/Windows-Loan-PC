#Requires -RunAsAdministrator

# Basic config.
$username = "Test"
$password = ConvertTo-SecureString "PASSWORD" -AsPlainText -Force
$description = "User for borrowing"


# Advanced config.
$localUserExist = Get-LocalUser | Where-Object {$_.name -eq $username}
$language = Get-Culture | select -ExpandProperty "Name"


# Bad scripting, should not rely on language.
if ($language -eq "en-US")
{
    $group = "Users"
} else {
    $group = "Brukere"
}

if ($localUserExist)
{
    Remove-LocalUser -Name $username
}


New-LocalUser -Name $username -Password $password -Description $description -UserMayNotChangePassword -PasswordNeverExpires -Confirm

Add-LocalGroupMember -Group $group -Member $username
