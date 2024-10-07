# Workspace ONE Logging Function

This PowerShell script provides a logging function to enable local log collection for any Workspace ONE (WS1) sensor or script.

## Description

The logging function allows you to log messages with different severity levels (Info, Warning, Error, Debug) and saves them to a specified log file.

## Usage

1. **Start the collection for device logs via the WS1 UEM Console**:
   - Navigate to the Workspace ONE UEM admin console.
   - Go to `Devices > Select a device > More Actions > Request Device Log`.
   - Make sure to select "HUB" logs

2. **Download Device Logs**:
   - Navigate to `Devices > Select the same device > More > Shred Device Logs`.
   - Download the spanned `.zip` files. WS1 separates the logs into parts; there might be more than one file.

## Function Overview

### `Write-Log`

- **Parameters**:
  - `-Message` (Mandatory): The log message to be recorded.
  - `-LogLevel` (Mandatory): The level of the log message. Options are `Info`, `Warning`, `Error`, `Debug`.

### Example Usage

```powershell
# Import the logging function
. .\Logging.ps1

Write-Log -Message "Starting the script execution." -LogLevel "Info"
# Your script logic here...
Write-Log -Message "Successfully completed the file extraction." -LogLevel "Info"
Write-Log -Message "This is a warning message." -LogLevel "Warning"
Write-Log -Message "An error occurred while processing." -LogLevel "Error"
```
