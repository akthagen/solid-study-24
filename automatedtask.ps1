# This is the basic layout for automate a task with powershell
# For more information read L9

# In cmd get-scheduledTask and look for it -taskName "test spacex"
# And look at get-scheduledTask -taskName "test spacex"| get-scheduledTaskinfo


# Define a trigger daily at 20:00
$trigger = New-ScheduledTaskTrigger -At 20:00 -Daily

# Define the action to execute PowerShell and run "testspacex.ps1"
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-File 'c:\Scripts\testspacex.ps1'"

# Default task settings
$settings = New-ScheduledTaskSettingsSet

# Register the scheduled task
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Test SpaceX" -Description "Test the connection with SpaceX.com"