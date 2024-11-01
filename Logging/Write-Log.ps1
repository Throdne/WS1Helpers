function Manage-LogFile {
    param (
        [string]$baseLogFileName,
        [string]$logFilePath,
        [int]$maxSizeBytes,
        [int]$maxFiles
    )

    $logFile = Join-Path $logFilePath "$baseLogFileName.log"

    # Check if the main log file exists
    if (Test-Path $logFile) {
        $logFileSize = (Get-Item $logFile).Length

        # Rotate logs if size exceeds the limit
        if ($logFileSize -ge $maxSizeBytes) {
            # Rotate existing log files
            for ($i = $maxFiles; $i -ge 1; $i--) {
                $oldLogFile = Join-Path $logFilePath "$($baseLogFileName)_$i.log"
                if (Test-Path $oldLogFile) {
                    if ($i -eq $maxFiles) {
                        Remove-Item -Path $oldLogFile -Force
                        Write-Log -LogLevel "Info" -Message "Deleted oldest log file: $baseLogFileName_$i.log"
                    } else {
                        Rename-Item -Path $oldLogFile -NewName (Join-Path $logFilePath "$($baseLogFileName)_$($i + 1).log") -Force
                    }
                }
            }
            Rename-Item -Path $logFile -NewName (Join-Path $logFilePath "$($baseLogFileName)_1.log")
            Write-Log -LogLevel "Info" -Message "Log file rotated: $($baseLogFileName)_1.log"
        }
    }
    # Delete old log files if exceeding the max count
    $logFiles = Get-ChildItem -Path $logFilePath -Filter "$($baseLogFileName)_*.log" | Sort-Object LastWriteTime
    if ($logFiles.Count -gt $maxFiles) {
        $logFiles[0..($logFiles.Count - $maxFiles - 1)] | ForEach-Object {
            Remove-Item -Path $_.FullName -Force
            Write-Log -LogLevel "Info" -Message "Deleted old log file: $($_.Name)"
        }
    }
}

function Write-Log {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Message,

        [Parameter(Mandatory = $true)]
        [ValidateSet("Info", "Warning", "Error", "Debug")]
        [string]$LogLevel
    )

    $formattedMessage = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') [$LogLevel] - $Message"
    $formattedMessage | Out-File -FilePath (Join-Path $LogFilePath "$baseLogFileName.log") -Append -Encoding UTF8
}

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
