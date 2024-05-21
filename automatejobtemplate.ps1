# Import the PSScheduledJob module
Import-Module PSScheduledJob

# Define a daily trigger at 20:00 (8:00 PM)
$Trigger = New-JobTrigger -Daily -At 20:00

# Define the script block to run the PowerShell script
# The adress is only for my machine, your might be diffent
$Scriptblock = {
    'C:\Scripts\testspacex.ps1'
}

# Register the scheduled job with the specified trigger and script block
Register-ScheduledJob -Name "TestSpaceX Job" -ScriptBlock $Scriptblock -Trigger $Trigger