$ErrorActionPreference = 'Continue'

$packages = @('octelium', 'octeliumctl', 'octops')

$registryPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
)

foreach ($pkg in $packages) {
    Write-Output "Searching registry for $pkg..."
    
    $installedApps = Get-ItemProperty $registryPaths -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName -eq $pkg }
    
    if ($null -ne $installedApps) {
        foreach ($app in @($installedApps)) {
            $productCode = $app.PSChildName
            Write-Output "Found $($app.DisplayName) with ProductCode $productCode. Triggering uninstall..."
            
            $process = Start-Process -FilePath "msiexec.exe" -ArgumentList "/x `"$productCode`" /quiet /norestart" -Wait -PassThru
            
            if ($process.ExitCode -in @(0, 1641, 3010)) {
                Write-Output "Successfully uninstalled $pkg."
            } else {
                Write-Error "Failed to uninstall $pkg. msiexec exit code: $($process.ExitCode)"
                exit 1
            }
        }
    } else {
        Write-Output "$pkg does not appear to be installed (no registry match found)."
    }
}