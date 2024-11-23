REM Installing Chocolatey
powershell -NoProfile -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"

REM Installing chocolatey packages
choco install packages.config --confirm

REM Confuring disks
:: Check if PowerShell script exists, then run it
if exist "AssignDriveLetters.ps1" (
    powershell -ExecutionPolicy Bypass -File "AssignDriveLetters.ps1"
) else (
    echo PowerShell script not found. Please check the path.
)
pause