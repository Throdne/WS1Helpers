$LogFilePath = "$env:ProgramData\Airwatch\UnifiedAgent\Logs"
$LogFileName = "FileName.log"

function Write-Log {
    Param (
        [Parameter(Mandatory = $true)]
        [string]$Message,

        [Parameter(Mandatory = $true)]
        [ValidateSet("Info", "Warning", "Error", "Debug")]
        [string]$LogLevel = "Info"
    )

    If (-not (Test-Path $LogFilePath)) {
        New-Item -ItemType Directory -Path $LogFilePath -Force
    }

    $time = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    $formattedMessage = "$time [$LogLevel] - $Message"
    $formattedMessage | Out-File -FilePath "$LogFilePath\$LogFileName" -Append -Encoding UTF8
}

# Example usage
# Write-Log -Message "Starting the script execution." -LogLevel "Info"
# Your script logic here...
# Write-Log -Message "Successfully completed the file extraction." -LogLevel "Info"
# Write-Log -Message "This is a warning message." -LogLevel "Warning"
# Write-Log -Message "An error occurred while processing." -LogLevel "Error"
