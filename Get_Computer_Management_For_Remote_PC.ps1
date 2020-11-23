<#---------------------------------
    Author: Sean Dyer
    Department: Educational Technologies
    Description: This script will open computer management on a remote PC.
    Version: 1.0 (Initial version: 11/20/2020)
    Usage: Get-RemoteComputerManagement -ComputerName "PCS122Q"
-----------------------------------#>


function Get-RemoteComputerManagement { [CmdletBinding()] 
    param([Parameter(Mandatory)] [string] $ComputerName="PCS7996")
    #Call the computer management snap-in and pass the parameter...
    compmgmt /computer:$ComputerName
}

#Call the function
Get-RemoteComputerManagement