# Get the directory of the script
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

# Define the path to the CSV file
$csvPath = Join-Path -Path $scriptDir -ChildPath ".\fake payroll.csv"

# Import the CSV data
$payrollData = Import-Csv -Path $csvPath

# Initialize lists
$teachers = @()
$principals = @()
$secretaries = @()
$employeesBySalary = @{}

# Process each record
foreach ($employee in $payrollData) {
    # Add to role-based lists
    switch ($employee.Role) {
        "Teacher" { $teachers += $employee }
        "Principal" { $principals += $employee }
        "Secretary" { $secretaries += $employee }
        default { $null }
    }

    # Add to salary-based dictionary
    $salary = [int]$employee.Salary
    if (-not $employeesBySalary.ContainsKey($salary)) {
        $employeesBySalary[$salary] = @()
    }
    $employeesBySalary[$salary] += $employee
}

# Output lists
Write-Output "Teachers:"
$teachers | Format-Table -AutoSize

Write-Output "Principals:"
$principals | Format-Table -AutoSize

Write-Output "Secretaries:"
$secretaries | Format-Table -AutoSize

Write-Output "Employees grouped by salary:"
$employeesBySalary.GetEnumerator() | Sort-Object Key | ForEach-Object {
    Write-Output "Salary: $($_.Key)"
    $_.Value | Format-Table -AutoSize
}
