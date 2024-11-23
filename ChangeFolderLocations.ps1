function Create-FolderIfNotExist {
    param (
        [string]$folderPath
    )

    if (-not (Test-Path $folderPath)) {
        New-Item -ItemType Directory -Path $folderPath
        Write-Host "Created folder: $folderPath"
    }
}

# Change Downloads folder to F:\Downloads
$downloadsPath = "F:\Downloads"
Create-FolderIfNotExist -folderPath $downloadsPath

$downloadsFolder = [System.Environment]::GetFolderPath('Downloads')
if (Test-Path $downloadsFolder) {
    Write-Host "Moving Downloads folder from $downloadsFolder to $downloadsPath"
    [System.IO.Directory]::Move($downloadsFolder, $downloadsPath)
} else {
    Write-Host "Downloads folder does not exist, creating it at $downloadsPath"
}

# Set the environment variable for Downloads
[Environment]::SetEnvironmentVariable('USERPROFILE', 'F:\', [System.EnvironmentVariableTarget]::User)
Write-Host "Updated Downloads folder location to $downloadsPath"

# Change Documents folder to F:\Documents
$documentsPath = "F:\Documents"
Create-FolderIfNotExist -folderPath $documentsPath

$documentsFolder = [System.Environment]::GetFolderPath('MyDocuments')
if (Test-Path $documentsFolder) {
    Write-Host "Moving Documents folder from $documentsFolder to $documentsPath"
    [System.IO.Directory]::Move($documentsFolder, $documentsPath)
} else {
    Write-Host "Documents folder does not exist, creating it at $documentsPath"
}

# Set the environment variable for Documents
[Environment]::SetEnvironmentVariable('MYDOCUMENTS', $documentsPath, [System.EnvironmentVariableTarget]::User)
Write-Host "Updated Documents folder location to $documentsPath"

# Change Pictures folder to F:\Pictures
$picturesPath = "F:\Pictures"
Create-FolderIfNotExist -folderPath $picturesPath

$picturesFolder = [System.Environment]::GetFolderPath('MyPictures')
if (Test-Path $picturesFolder) {
    Write-Host "Moving Pictures folder from $picturesFolder to $picturesPath"
    [System.IO.Directory]::Move($picturesFolder, $picturesPath)
} else {
    Write-Host "Pictures folder does not exist, creating it at $picturesPath"
}

# Set the environment variable for Pictures
[Environment]::SetEnvironmentVariable('MYPICTURES', $picturesPath, [System.EnvironmentVariableTarget]::User)
Write-Host "Updated Pictures folder location to $picturesPath"


Write-Host "Folders have been successfully moved to the F: drive."