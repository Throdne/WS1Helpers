# WS1 Helper Scripts
Helper Script Files for WorkSpace One UEM or Intelligence

## UnzipSpannedLogFiles.ps1
Unzip spanned log files downloaded from Workspace One admin console.

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