<#---------------------------------
    Author: Sean Dyer
    Department: Educational Technologies
    Description: This script will poll a remote PC for hotfix and security update information
    Version: 1.0.1 (Initial version: 11/10/2020), version 1.0.1 (11/11/2020) added piping information to a text file
-----------------------------------#>

#Prompt the user for a computer name...
$pcToConnectTo = Read-Host -Prompt "Which PC would you like to view Hotfix and Security Updates on?"

#Let us determine if we've got a PC to work with...
if ($pcToConnectTo) {
    #Let us display some feedback to the user...
    Write-Host "Getting Hotfixes..."
    #Get the current user's desktop folder...
    $currentUserDesktop = [environment]::GetFolderPath('Desktop')
    #Prompt the user for the file name...
    $fileName = Read-Host -Prompt "What would you like to call the output file?"
    #Determine if we have a file name or not...
    if ($fileName) {
        #Run the get hotfix command and pipe it out to a text file...
        Get-HotFix -ComputerName $pcToConnectTo | Out-File "$currentUserDesktop\$fileName.txt"
    } else {
        #Display output to the user...
        Write-Host "Please enter a name for the output file..."
    }
} else {
    #Display a message to the user that they have to enter a PC name...
    Write-Host "Please enter the PC's name..."
}