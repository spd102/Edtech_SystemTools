# Set-ExecutionPolicy unrestricted

<#---------------------------------
    Author: Sean Dyer
    Department: Educational Technologies
    Description: This script checks the Panopto Remote Recorder Service and turns it on if off on a remote PC
    Version: 1.0 (Initial version: 11/4/2020)
-----------------------------------#>

#Prompt user for PC's asset tag
$pcToCheck = Read-Host -Prompt "Which PC would you like to check the Panopto Remote Recorder Service on?"
#Set the service name as a variable for later use
$serviceName = "PanoptoRemoteRecorderService"
#Check the service
$serviceCall = Get-Service -ComputerName $pcToCheck -Name $serviceName -ErrorAction SilentlyContinue

#Let's first find out if this service even exists first
if ($serviceCall -eq $null) {
    #Display some feedback to the user since this service does not exist...
    Write-Host "The Panopto Remote Recorder Service does not exist on this PC..."
} else {
    #If we made it here, the service does exist, let's find out if it's running...
    #Check to see if the service is not running
    if ($serviceCall.Status -eq "Stopped") {
        #Let's tell the user what we're doing before we do it...
        Write-Host "Attempting to restart Panopto Remote Recorder Service.."
        #Pause for n seconds
        Start-Sleep -Seconds 15
        #If we're here, the service isn't running, let's start it
        Get-Service $serviceName -ComputerName $pcToCheck | Start-Service
        #Let's tell the user what we're doing before we do it...
        Write-Host "Running the start service command on the Panopto Remote Recorder Service..."
        #Pause for n seconds
        Start-Sleep -Seconds 15
        #Display final status message
        Write-Host "The Panopto Remote Recorder Service is now running..."
    } else {
        #If we made it here, the service is probably already running...
        Write-Host "The Panopto Remote Recorder Service is already running..."
    }
}