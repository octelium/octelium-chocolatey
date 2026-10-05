$ErrorActionPreference = 'Stop'

$script:uninstalled = @()
$script:installedApps = @()

function Get-UninstallRegistryKey {
    param([string]$SoftwareName)
    if ($SoftwareName -ne 'Octelium Desktop') {
        throw 'Uninstallation must search for the exact desktop application name.'
    }
    return $script:installedApps | Where-Object { $_.DisplayName -eq $SoftwareName }
}

function Uninstall-ChocolateyPackage {
    param(
        [string]$PackageName,
        [string]$FileType,
        [string]$SilentArgs,
        [int[]]$ValidExitCodes
    )
    $match = [regex]::Match($SilentArgs, '^(\{[0-9a-fA-F-]{36}\}) /quiet /norestart$')
    if ($PackageName -ne 'octelium-desktop' -or $FileType -ne 'msi' -or -not $match.Success) {
        throw 'The desktop MSI must uninstall silently using the Chocolatey helper.'
    }
    $script:uninstalled += $match.Groups[1].Value
}

$uninstallScript = Join-Path $PSScriptRoot '../../octelium-desktop/tools/chocolateyUninstall.ps1'
$productCode = '{371FB972-3FD1-48E8-AC16-EBB1C2AAB6A9}'
$script:installedApps = @(
    [pscustomobject]@{ DisplayName = 'Octelium Desktop'; WindowsInstaller = 1; PSChildName = $productCode },
    [pscustomobject]@{ DisplayName = 'octelium'; WindowsInstaller = 1; PSChildName = '{11111111-1111-1111-1111-111111111111}' },
    [pscustomobject]@{ DisplayName = 'Microsoft Edge WebView2 Runtime'; WindowsInstaller = 1; PSChildName = '{22222222-2222-2222-2222-222222222222}' },
    [pscustomobject]@{ DisplayName = 'Octelium Desktop'; WindowsInstaller = 0; PSChildName = 'NSIS installer' }
)
. $uninstallScript
if ($script:uninstalled.Count -ne 1 -or $script:uninstalled[0] -ne $productCode) {
    throw 'Only the desktop MSI should be uninstalled.'
}

$script:installedApps = @()
$script:uninstalled = @()
. $uninstallScript
if ($script:uninstalled.Count -ne 0) {
    throw 'An absent desktop MSI should not trigger an uninstall.'
}

$script:installedApps = @([pscustomobject]@{ DisplayName = 'Octelium Desktop'; WindowsInstaller = 1; PSChildName = 'invalid' })
$rejected = $false
try {
    . $uninstallScript
} catch {
    if ($_.Exception.Message -ne 'Invalid Octelium Desktop MSI product code.') { throw }
    $rejected = $true
}
if (-not $rejected -or $script:uninstalled.Count -ne 0) {
    throw 'An invalid MSI product code must be rejected.'
}

Write-Output 'Desktop uninstall selection tests passed.'
