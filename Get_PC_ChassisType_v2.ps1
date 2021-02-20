<#---------------------------------
    Author: Sean Dyer
    Department: Educational Technologies
    Description: This script sets a custom registry property based on the PC's ChassisType
    Version: 1.1 (Initial version: 11/5/2020)
-----------------------------------#>

# Determine which type of PC this is...
$Chassis_Type_Number = (Get-WmiObject Win32_SystemEnclosure).ChassisTypes
# Chassis Type values from https://technet.microsoft.com/en-us/library/ee156537.aspx

#Filter off the number returned from the ChassisTypes collection
Switch ($Chassis_Type_Number) {
    #Desktop, All in One, treat as a desktop
    3 { $Chassis_Type = "Desktop" }
    13 { $Chassis_Type = "Desktop" }
    #Laptop, Notebook, treat as a laptop
    10 { $Chassis_Type = "Laptop" }
    9 { $Chassis_Type = "Laptop" }
}

#Write out this custom property to the registry. This helps us with jobs and conditional branching in PDQ Deploy
#Especially with GroupPolicies and SecurityPolicies
New-ItemProperty -Path "HKLM:\HARDWARE\DESCRIPTION\System" -Name "ChassisType" -PropertyType "String" -Value $Chassis_Type -Force