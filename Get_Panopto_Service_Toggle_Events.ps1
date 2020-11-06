<#---------------------------------
    Author: Sean Dyer
    Department: Educational Technologies
    Description: This script checks the Application log on a remote PC for start/stop events (EventID 12906) for the PanoptoServiceToggle application
    Version: 1.0 (Initial version: 11/6/2020)
-----------------------------------#>

#Prompt user for PC's asset tag
$pcToConnectTo = Read-Host -Prompt "Which PC would you like to view the PanoptoServiceToggle events on?"

#Let's find out if we've got an asset tag to work with...
if ($pcToConnectTo) {
    #Prompt the use for the max amount of records to return...
    $maxNumberEvents = Read-Host -Prompt "How many PanoptoServiceToggle event instances would you like to return?"
    #Let's find out if we got a number to work with...
    if ($maxNumberEvents) {
        #Display some feedback to the end user...
        Write-Host "Checking the Application log on $pcToConnectTo for PanoptoServiceToggle events..."
        #Create a variable to keep this around to print out...
        $toggleEvents = Get-WinEvent -ComputerName $pcToConnectTo -FilterHashtable @{logname='application'; id=12906} -MaxEvents $maxNumberEvents -ErrorAction SilentlyContinue
        if ($toggleEvents.Count -eq 0) {
            Write-Host "Sorry, there are no events returned..."
        } else {
            #Call variable and print out the call using stdin...
            $toggleEvents
        }
    } else {
        #Display some feedback to the user, they forgot to add the max number of records to return...
        Write-Host "Please enter the maximum number of events you would to return?"
    }
} else {
    #Display some feedback to the end user that they didn't enter an asset tag...
    Write-Host "Please enter the name of a PC you'd like to view the PanoptoServiceToggle events on..."
}