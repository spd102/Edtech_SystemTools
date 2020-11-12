<#---------------------------------
    Author: Sean Dyer
    Department: Educational Technologies
    Description: This script will poll a remote PC for a specified number of a specified event log and pipe it out to the current user's desktop
    Version: 1.0 (Initial version: 11/11/2020)
-----------------------------------#>

#Get the current user's desktop folder...
$currentUserDesktop = [environment]::GetFolderPath('Desktop')

#Prompt the user for a computer name...
$pcToConnectTo = Read-Host -Prompt "Which PC would you like to view event logs on?"
#Let us determine if we've got a PC to work with...
if ($pcToConnectTo) {
    #If we made it here, prompt for more info...
    $requestedLog = Read-Host -Prompt "Which event log would you like to view events from?"
    #Let's see if we got a log name to work with?
    if ($requestedLog) {
        #Let the user know what's going on..
        Write-Host "You have specified the $requestedLog event log..."
        #Let's now ask the user how many log entries to return...
        $requestedAmount = Read-Host -Prompt "How many event log entries would you like to retrieve?"
        #Do we have a number to work with?
        if ($requestedAmount) {
            #Display some feedback...
            Write-Host "You have specified $requestedAmount entries from $pcToConnectTo to return..."
            #Make the call to retrieve these items...
            $logEvents = Get-EventLog -LogName $requestedLog -ComputerName $pcToConnectTo -Newest $requestedAmount
            #Create a dynamic file name based on this criteria...
            $fileNameString = -join($pcToConnectTo, "_", "errors", ".txt")
            #Filter out based on this criteria...
            $logEvents | Where-Object {$_.EntryType -match "error"} | Out-File "$currentUserDesktop\$fileNameString"
            #Display output...
            Write-Host "Your $requestedAmount $requestedLog events from $pcToConnectTo have been written out to $currentUserDesktop\$fileNameString"
        } else {
            #No specified number of records...
            Write-Host "Please specify how many records you'd like to return..."
        }
    } else {
        #Let the user know what's up...
        Write-Host "Please specify what event log you'd like to see events from..."
    }
} else {
    #Display some feedback to the user...
    Write-Host "Please enter the PC's name..."
}