<#
Author: Jerico Thomas
Date Updated: 2024-10-07
Description: Unzip spanned log files from Workspace One admin console.
Version: 1.1
Dependencies: 7-Zip

Parameters:
    - 7zipPath: (string) Path to the 7-Zip executable (default: "C:\Program Files\7-Zip\7z.exe")
    - Keep: (switch) If specified, keep original zipped files after extraction.

Generate Device Logs:
1. Navigate to the Workspace One admin console.
2. Go to Devices > Select a device > More Actions > Request Device Log.

Download Device Logs:
1. Navigate to Devices > Select the same device > More > Shred Device Logs.
2. Download the spanned.zip files (each part is 10MB).

Script Guide:
1. Download the spanned.zip files from the Workspace One admin console.
2. Create an empty folder and place the spanned.zip files in it.
3. Place this script in the same folder as the spanned.zip files.
4. Run the script.
5. The script extracts the spanned.zip files and cleans up the folder, leaving only the extracted files.

Example Execution:
1. To run the script with default parameters:
   ```powershell
   .\UnzipSpannedLogFiles.ps1
    ```
2. To specify a custom path for the 7-Zip executable:
    ```powershell
    .\UnzipSpannedLogFiles.ps1 -7zipPath "C:\CustomPathTo7zip\7z.exe"
     ```
3.  To run the script and keep the original zipped files after extraction:
    ```powershell
    .\UnzipSpannedLogFiles.ps1 -keep
    ```
#>

param (
    [string]$7zipPath = "C:\Program Files\7-Zip\7z.exe",
    [switch]$Keep = $false
)

# Check if 7-Zip is installed
if (!(Test-Path -Path $7zipPath)) {
    Write-Output "7-Zip not found at '$7zipPath'. Please install 7-Zip."
    exit 1
}

# Remove .zip extension from any files that have spanned.zxx.zip in the name
Get-ChildItem -Filter "*spanned.*.zip" | Rename-Item -NewName { $_.Name -replace '\.zip$', '' } -ErrorAction Stop

# Extract spanned zip files
$zipFile = Get-ChildItem -Filter "*spanned.zip"
if ($zipFile) {
    & $7zipPath x $zipFile.FullName -oSpannedFiles -y

    # Find all .zip files in the output directory recursively
    $innerZipFiles = Get-ChildItem -Path SpannedFiles -Filter "*.zip" -Recurse -ErrorAction Stop

    # Extract all inner zip files
    foreach ($file in $innerZipFiles) {
        & $7zipPath x $file.FullName -y
    }

    if (!$Keep) {
        # Create Archived folder if it doesn't exist
        if (!(Test-Path -Path $archiveDir)) {
            New-Item -ItemType Directory -Path $archiveDir -ErrorAction Stop
        }
        # Move original zip files to the Archived folder
        Get-ChildItem -Filter "*spanned.*" | Move-Item -Destination $archiveDir -ErrorAction Stop
        # Remove the SpannedFiles directory
        Remove-Item -Path SpannedFiles -Recurse -Force -ErrorAction Stop
        Remove-Item -Path Archived -Recurse -Force -ErrorAction Stop
    }
}
else {
    Write-Output "No spanned zip files found."
}

exit 0
