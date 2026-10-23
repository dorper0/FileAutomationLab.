
# Get the current date and calculate the cutoff date
$currentDate = Get-Date
$cutoffDate = $currentDate.AddDays(-7)

Write-Host "Current Date: $currentDate"
Write-Host "Cutoff Date: $cutoffDate"
Write-Host ""

# Find files modified more than 7 days ago
$oldFiles = Get-ChildItem -File | Where-Object {
    $_.LastWriteTime -lt $cutoffDate
}

Write-Host "Files modified more than 7 days ago:"
$oldFiles | Select-Object Name, LastWriteTime

# Test copying old files without actually copying them
Write-Host ""
Write-Host "Testing file operation with WhatIf:"

foreach ($file in $oldFiles) {
    Copy-Item -Path $file.FullName `
        -Destination "$($file.FullName).backup" -WhatIf
}

Write-Host ""
Write-Host "Script completed."
