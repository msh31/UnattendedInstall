REM Installing Chocolatey
powershell -NoProfile -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"

REM Installing chocolatey packages
choco install packages.config --confirm

REM Confuring disks
if exist "AssignDriveLetters.ps1" (
    powershell -ExecutionPolicy Bypass -File "AssignDriveLetters.ps1"
) else (
    echo PowerShell script not found. Please check the path.
)
pause

REM Confuring Downloads / Documents / Pictures locations
if exist "ChangeFolderLocations.ps1" (
    powershell -ExecutionPolicy Bypass -File "ChangeFolderLocations.ps1"
) else (
    echo PowerShell script not found. Please check the path.
)
pause

REM Setting monitor configuration
:: Removing 144/120hz modes from AOC G2G4 and setting it to portrait & Removing 4K resolution from MSI G273Q
if exist "SetMonitorConfig.ps1.ps1" (
    powershell -ExecutionPolicy Bypass -File "SetMonitorConfig.ps1.ps1"
) else (
    echo PowerShell script not found. Please check the path.
)
pause

REM Done!