# Define which drive should get which letter
$assignments = @(
    @{ Path = "\\?\Volume{1ef5db00-0000-0000-0000-100000000000}\"; DesiredLetter = "D" },
    @{ Path = "\\?\Volume{3ba41ec5-7b55-47fc-855f-2bed5d758081}\"; DesiredLetter = "E" },
    @{ Path = "\\?\Volume{88cba12f-7d9c-4826-9fd2-31ef15d9c927}\"; DesiredLetter = "F" },
    @{ Path = "\\?\Volume{caae85b4-40e0-11ed-9d7b-806e6f6e6963}\"; DesiredLetter = "G" },
    @{ Path = "\\?\Volume{b5ce44cb-7e36-11ef-8a02-806e6f6e6963}\"; DesiredLetter = "Z" }
)

# Apply the letters
foreach ($assignment in $assignments) {
    $volume = Get-Volume | Where-Object { $_.Path -eq $assignment.Path }
    if ($volume) {
        try {
            # Assign the desired drive letter
            Set-Partition -DriveLetter $volume.DriveLetter -NewDriveLetter $assignment.DesiredLetter -ErrorAction Stop
            Write-Host "Assigned letter $($assignment.DesiredLetter) to volume at path $($assignment.Path)."
        } catch {
            Write-Host "Failed to assign letter $($assignment.DesiredLetter) to volume at path $($assignment.Path): $_"
        }
    } else {
        Write-Host "Volume with Path '$($assignment.Path)' not found."
    }
}

# Ensure dynamic disks are online and imported if they are foreign
Get-Disk | Where-Object { $_.OperationalStatus -eq "Foreign" } | ForEach-Object { Import-Disk -Number $_.Number }