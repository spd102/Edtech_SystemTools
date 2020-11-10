<#---------------------------------
    Author: Sean Dyer
    Department: Educational Technologies
    Description: This script will poll a remote PC for hotfix and security update information
    Version: 1.0 (Initial version: 11/10/2020)
-----------------------------------#>

#Prompt the user for a computer name...
$pcToConnectTo = Read-Host -Prompt "Which PC would you like to view Hotfix and Security Updates on?"

#Let us determine if we've got a PC to work with...
if ($pcToConnectTo) {
    #Let us display some feedback to the user...
    Write-Host "Getting Hotfixes..."
    #Display hotfixes via stdout...
    Get-HotFix -ComputerName $computer
} else {
    #Display a message to the user that they have to enter a PC name...
    Write-Host "Please enter the PC's name..."
}