<#---------------------------------
    Author: Sean Dyer
    Department: Educational Technologies
    Description: This script returns the IPv4 address on a remote PC
    Version: 1.0 (Initial version: 12/8/2020)
-----------------------------------#>

#Prompt user for PC's asset tag
$pcToConnectTo = Read-Host -Prompt "Which PC would you like to get the IPv4 address of?"

if ($pcToConnectTo) {
    #Run the command to return the PC's IPv4's address...
    (Get-CimInstance -ComputerName $pcToConnectTo -ClassName Win32_NetworkAdapterConfiguration -Filter "IPEnabled = 'true'").IPAddress[0]
} else {
    #Display info to the user, that they need to add the name of the PC...
    Write-Host "Please enter the name of the PC you would like to get the IPv4 address of."
}