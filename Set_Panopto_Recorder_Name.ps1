<#---------------------------------
    Author: Sean Dyer
    Department: Educational Technologies
    Description: This script sets the Panopto Remote Recorder Regsitry Description on a remote PC
    Version: 1.0 (Initial version: 11/5/2020)
-----------------------------------#>

#Prompt user for PC's asset tag
$pcToConnectTo = Read-Host -Prompt "Which PC would you like to change the Panopto Remote Recorder name on?"

if ($pcToConnectTo) {
    #Prompt user for name to change the recorder name to...
    $newRecorderName = Read-Host -Prompt "What would like to rename this recorder to?"
} else {
    #Display info to the user, that they need to add the name of the PC...
    Write-Host "Please enter the name of the PC you would like to change the Remote Recorder's name on."
}

if ($newRecorderName) {
    #Attempt to change the registry entry on this PC...
    Write-Host "Running the rename command now..."
    #Attempt to change the regsitry entry...
    Invoke-Command –ComputerName $pcToConnectTo –ScriptBlock { 
        #Set the property for the recorder name, this is for the 64bit version
        Set-ItemProperty "HKLM:\SOFTWARE\Panopto\Panopto Recorder" -Name "Description" -Value $Using:newRecorderName -Force
    }
    #Display some output to the user...
    Write-Output "Changed the Recorder name on $pcToConnectTo to $newRecorderName"
    #Let's pause for a minute to let this sink in...
    Start-Sleep -Seconds 15
    #Let's let the user know we're rebooting this PC...
    Write-Host "Rebooted PC $pcToConnectTo..."
    #Restart this PC now..
    Restart-Computer -ComputerName $pcToConnectTo -Force
} else {
    #Let's let the user know they didn't add a recorder name...
    Write-Host "Please enter the new name for this Remote Recorder..."
}