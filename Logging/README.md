# Workspace ONE Logging Function

This PowerShell script provides a logging function to enable local log collection for any Workspace ONE (WS1) sensor or script.

## Description

The logging function allows you to log messages with different severity levels (Info, Warning, Error, Debug) and saves them to a specified log file.

## Function Overview

### `Write-Log`

- **Parameters**:
  - `-Message` (Mandatory): The log message to be recorded.
  - `-LogLevel` (Mandatory): The level of the log message. Options are `Info`, `Warning`, `Error`, `Debug`.

### `Manage-LogFile`
- **Parameters**:
  - `-baseLogFileName` (Mandatory): The base log file name
  - `-LogFilePath` (Mandatory): The log file location
  - `-maxSizeMB` (Mandatory): the max log file size in MB
  - `-maxFiles` (Mandatory): Maximum number of rotated log files

### Example Usage

```powershell
# Example usage
### Main Script ###
$baseLogFileName = "example"  # Set the base log file name
$LogFilePath = "$env:ProgramData\Airwatch\UnifiedAgent\Logs"
$maxSizeMB = 5  # Maximum log file size in MB
$maxSizeBytes = $maxSizeMB * 1MB
$maxFiles = 4    # Maximum number of rotated log files

Manage-LogFile -baseLogFileName $baseLogFileName -logFilePath $LogFilePath -maxSizeBytes $maxSizeBytes -maxFiles $maxFiles

Write-Log -LogLevel "Info" -Message "Starting Script"
# Continue with the rest of your script...
```

# Unzip Spanned Log File
Unzip spanned log files downloaded from Workspace One UEM admin console.

## Collect and Downlaod Logs from WS1 UEM

1. **Start the collection for device logs via the WS1 UEM Console**:
   - Navigate to the Workspace ONE UEM admin console.
   - Go to `Devices > Select a device > More Actions > Request Device Log`.
   - Make sure to select "HUB" logs

2. **Download Device Logs**:
   - Navigate to `Devices > Select the same device > More > Shred Device Logs`.
   - Download the spanned `.zip` files. WS1 separates the logs into parts; there might be more than one file.

## Example Execution:

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
