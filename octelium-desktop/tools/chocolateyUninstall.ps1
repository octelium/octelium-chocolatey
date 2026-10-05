$ErrorActionPreference = 'Stop'

$installedApps = Get-UninstallRegistryKey -SoftwareName 'Octelium Desktop' | Where-Object { $_.WindowsInstaller -eq 1 }

foreach ($app in @($installedApps)) {
    if ($null -eq $app) { continue }
    if ($app.PSChildName -notmatch '^\{[0-9a-fA-F-]{36}\}$') {
        throw 'Invalid Octelium Desktop MSI product code.'
    }

    $packageArgs = @{
        packageName    = 'octelium-desktop'
        fileType       = 'msi'
        silentArgs     = "$($app.PSChildName) /quiet /norestart"
        validExitCodes = @(0, 1605, 1614, 3010, 1641)
    }

    Uninstall-ChocolateyPackage @packageArgs
}
