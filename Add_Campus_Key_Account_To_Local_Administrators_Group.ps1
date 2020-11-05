<#---------------------------------
    Author: Sean Dyer
    Department: Educational Technologies
    Description: This script will add an ActiveDirectory account to the local Administrator's group on a remote PC
    Version: 1.0 (Initial version: 11/5/2020)
-----------------------------------#>

#Prompt user for the domain
$accountDomain = Read-Host "Which domain is the account you'd like to add on?"

if ($accountDomain) {
    #Prompt user for PC's asset tag
    $pcToAddTo = Read-Host -Prompt "Which PC would you like to add this account to the administrator's group?"
} else {
    #Display a message to the user that they have to enter a domain..
    Write-Host "Please enter your domain..."
}

if ($pcToAddTo) {
    #Prompt user for the campus key account to add...
    $accountToAdd = Read-Host -Prompt "Which campus key would you like to add to the administrator's group?"
} else {
    #Display a message to the user that they have to enter a PC name...
    Write-Host "Please enter the PC's name..."
}

if ($accountToAdd) {
   #Create a reference to the administrator's group on the above PC...
    $pathToAdminGroup = [ADSI]"WinNT://$pcToAddTo/Administrators,group"
    #Create a reference to the user to add to the administrator's group
    $pathToUserAccount = [ADSI]"WinNT://$accountDomain/$accountToAdd,user"
    #Add the user to the group
    $pathToAdminGroup.Add($pathToUserAccount.Path)
    #Display some feedback to the user...
    Write-Host "Campus key $accountToAdd has been added to $pcToAddTo..."
} else {
    #Display a message to the user that they did not enter a campus key
    Write-Host "Please enter a campus key..."
}