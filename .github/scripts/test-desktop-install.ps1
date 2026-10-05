$ErrorActionPreference = 'Stop'

$script:capturedArgs = $null

function Get-ItemProperty {
    param([string]$Path, [string]$Name)
    if ($Path -ne 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' -or $Name -ne 'PROCESSOR_ARCHITECTURE') {
        throw 'The installer must read the native Windows architecture.'
    }
    return @{ PROCESSOR_ARCHITECTURE = $script:nativeArch }
}

function Install-ChocolateyPackage {
    param(
        [string]$PackageName,
        [string]$FileType,
        [string]$SilentArgs,
        [int[]]$ValidExitCodes,
        [string]$SoftwareName,
        [string]$Url64bit,
        [string]$Checksum64,
        [string]$ChecksumType64
    )
    $script:capturedArgs = $PSBoundParameters
}

$installScript = Join-Path $PSScriptRoot '../../octelium-desktop/tools/chocolateyInstall.ps1'
$originalArch = $env:PROCESSOR_ARCHITECTURE
$originalWowArch = $env:PROCESSOR_ARCHITEW6432

try {
    foreach ($case in @(
        @{ Native = 'AMD64'; Process = 'AMD64'; Wow = ''; Msi = 'x64' },
        @{ Native = 'AMD64'; Process = 'x86'; Wow = 'AMD64'; Msi = 'x64' },
        @{ Native = 'ARM64'; Process = 'ARM64'; Wow = ''; Msi = 'arm64' },
        @{ Native = 'ARM64'; Process = 'AMD64'; Wow = ''; Msi = 'arm64' },
        @{ Native = 'ARM64'; Process = 'x86'; Wow = 'ARM64'; Msi = 'arm64' }
    )) {
        $script:nativeArch = $case.Native
        $env:PROCESSOR_ARCHITECTURE = $case.Process
        $env:PROCESSOR_ARCHITEW6432 = $case.Wow
        $script:capturedArgs = $null
        . $installScript

        $captured = $script:capturedArgs
        if ($null -eq $captured -or $captured.PackageName -ne 'octelium-desktop' -or $captured.FileType -ne 'msi') {
            throw 'The desktop MSI must be installed using the Chocolatey helper.'
        }
        if ($captured.Url64bit -notmatch "_$($case.Msi)_en-US\.msi$" -or $captured.Checksum64 -notmatch '^[0-9a-f]{64}$' -or $captured.ChecksumType64 -ne 'sha256') {
            throw "Incorrect installer or checksum for native $($case.Native) under $($case.Process)."
        }
        if ($captured.SilentArgs -ne '/quiet /norestart' -or ($captured.ValidExitCodes -join ',') -ne '0,3010,1641') {
            throw 'The MSI must install silently and handle reboot exit codes.'
        }
    }

    $script:nativeArch = 'x86'
    $script:capturedArgs = $null
    $rejected = $false
    try {
        . $installScript
    } catch {
        if ($_.Exception.Message -ne 'Octelium Desktop requires an x64 or ARM64 version of Windows.') { throw }
        $rejected = $true
    }
    if (-not $rejected -or $null -ne $script:capturedArgs) {
        throw '32-bit Windows must be rejected before attempting installation.'
    }
} finally {
    $env:PROCESSOR_ARCHITECTURE = $originalArch
    $env:PROCESSOR_ARCHITEW6432 = $originalWowArch
}

Write-Output 'Desktop architecture selection tests passed.'
