﻿<#---------------------------------
    Author: Sean Dyer
    Department: Educational Technologies
    Description: This script will poll a remote PC for drive information and pipe it out to the current user's desktop
    Version: 1.0 (Initial version: 11/12/2020)
-----------------------------------#>

#Get the current user's desktop folder...
$currentUserDesktop = [environment]::GetFolderPath('Desktop')
#Prompt the user for a computer name...
$pcToConnectTo = Read-Host -Prompt "Which PC would you like to drive information on?"
#Let us find out if we've got a PC to work with...
if ($pcToConnectTo) {
    #Display feedback to the user...
    Write-Host "Running drive information commands..."
    #Create a dynamic file name based on this criteria...
    $fileNameString = -join($pcToConnectTo, "_", "drive_information", ".txt")
    #Running the logical disk command...
    Get-WmiObject Win32_LogicalDisk -ComputerName $pcToConnectTo | Format-Table | Out-File "$currentUserDesktop\$fileNameString"
    #Display output...
    Write-Host "Drive information from $pcToConnectTo have been written out to $currentUserDesktop\$fileNameString"

} else {
    #Display feedback to the user...
    Write-Host "Please enter a computer name you wish to see drive information..."
}
