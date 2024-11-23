$cruExePath = "F:\Programs\CRU\CRU.exe"
$profilePath = "F:\path\to\your\resolution_config.bin"
$primaryMonitorName = "MSI G273Q"

if (Test-Path $cruExePath) {
    Write-Host "Importing CRU profile..."
    Start-Process -FilePath $cruExePath -ArgumentList "-import $profilePath" -Wait
    Write-Host "Profile imported successfully."

    Write-Host "Restarting graphics driver..."
    Restart-GraphicsDriver
} else { Write-Host "CRU executable not found at $cruExePath." }

function Restart-GraphicsDriver {
    # Restart the display driver to apply changes without rebooting
    $displayDriver = Get-WmiObject -Class Win32_PnPEntity | Where-Object { $_.Description -like "*Display*" }

    if ($displayDriver) {
        Write-Host "Found display driver: $($displayDriver.Description). Restarting..."
        $displayDriver.Disable()
        Start-Sleep -Seconds 3
        $displayDriver.Enable()
        Write-Host "Graphics driver restarted successfully."
    } else { Write-Host "Display driver not found. Please check your system." }
}

function Set-PrimaryMonitor($monitorName) {
    # Get the monitor's DeviceID based on FriendlyName
    $monitors = Get-WmiObject -Namespace "root\wmi" -Class WmiMonitorID
    $primaryMonitor = $null

    foreach ($monitor in $monitors) {
        $currentMonitorName = [System.Text.Encoding]::ASCII.GetString($monitor.UserFriendlyName)
        if ($currentMonitorName -like "*$monitorName*") {
            $primaryMonitor = $monitor
            break
        }
    }

    if ($primaryMonitor) {
        Write-Host "Setting $monitorName as the primary monitor."
        $videoController = Get-WmiObject -Class Win32_VideoController
        $videoController.SetPrimaryMonitor($primaryMonitor.InstanceName)
        Write-Host "$monitorName set as primary monitor successfully."
    } else { Write-Host "$monitorName not found!" }
}

Set-PrimaryMonitor -monitorName $primaryMonitorName