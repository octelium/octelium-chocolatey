param(
    [Parameter(Mandatory = $true)]
    [string]$PackageDir,
    [string]$BaselineDir
)

$ErrorActionPreference = 'Stop'
$PackageDir = (Resolve-Path -LiteralPath $PackageDir).Path
$registryPaths = @(
    'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*',
    'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
)

function Invoke-Chocolatey {
    param([string[]]$ArgumentList)
    & choco @ArgumentList
    if ($LASTEXITCODE -notin @(0, 3010, 1641)) {
        throw "Chocolatey failed with exit code $LASTEXITCODE."
    }
}

function Get-PackageVersion {
    param([string]$Directory)
    [xml]$nuspec = Get-Content -LiteralPath (Join-Path $Directory 'octelium-desktop.nuspec') -Raw
    return [string]$nuspec.package.metadata.version
}

function Invoke-PackagePack {
    param([string]$Directory)
    Push-Location -LiteralPath $Directory
    try {
        Invoke-Chocolatey -ArgumentList @('pack', 'octelium-desktop.nuspec', '--output-directory', $Directory)
    } finally {
        Pop-Location
    }
}

function Get-DesktopRegistration {
    return @(Get-ItemProperty -Path $registryPaths -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName -eq 'Octelium Desktop' })
}

function Test-DesktopInstallation {
    param([string]$ExpectedVersion)
    $apps = @(Get-DesktopRegistration)
    if ($apps.Count -ne 1 -or ([version]$apps[0].DisplayVersion).ToString(3) -ne $ExpectedVersion -or $apps[0].WindowsInstaller -ne 1) {
        throw "Expected exactly one installed desktop MSI at version $ExpectedVersion."
    }

    $service = $null
    for ($attempt = 0; $attempt -lt 30; $attempt++) {
        $service = Get-CimInstance Win32_Service -Filter "Name='OcteliumDaemon'" -ErrorAction SilentlyContinue
        if ($null -ne $service -and $service.State -eq 'Running' -and $service.StartMode -eq 'Auto') { break }
        Start-Sleep -Seconds 1
    }
    if ($null -eq $service -or $service.State -ne 'Running' -or $service.StartMode -ne 'Auto') {
        throw 'The Octelium Desktop daemon service must run automatically.'
    }

    $match = [regex]::Match($service.PathName, '^"([^"]+)"|^(\S+)')
    $daemonPath = if ($match.Groups[1].Success) { $match.Groups[1].Value } else { $match.Groups[2].Value }
    $installDir = Split-Path -Path $daemonPath -Parent
    foreach ($filename in @('octelium-desktop.exe', 'octelium-desktop-daemon.exe', 'wireguard.dll', 'wintun.dll', 'install-daemon.ps1')) {
        if (-not (Test-Path -LiteralPath (Join-Path $installDir $filename) -PathType Leaf)) {
            throw "Missing installed desktop file: $filename"
        }
    }
    return $installDir
}

$version = Get-PackageVersion -Directory $PackageDir
$sentinelPath = Join-Path ([Environment]::GetFolderPath('CommonApplicationData')) 'Octelium Desktop/daemon-state/chocolatey-upgrade-test.txt'
$upgrade = $BaselineDir -and (Test-Path -LiteralPath $BaselineDir) -and ([version](Get-PackageVersion -Directory $BaselineDir) -lt [version]$version)

Invoke-PackagePack -Directory $PackageDir

if ($upgrade) {
    $baselineVersion = Get-PackageVersion -Directory $BaselineDir
    Invoke-PackagePack -Directory $BaselineDir
    Invoke-Chocolatey -ArgumentList @('install', 'octelium-desktop', '--version', $baselineVersion, '--source', $BaselineDir, '-y', '--no-progress')
    $installDir = Test-DesktopInstallation -ExpectedVersion $baselineVersion
    Set-Content -LiteralPath $sentinelPath -Value 'preserve desktop daemon state'
    Invoke-Chocolatey -ArgumentList @('upgrade', 'octelium-desktop', '--version', $version, '--source', $PackageDir, '-y', '--no-progress')
    if ((Get-Content -LiteralPath $sentinelPath -Raw).Trim() -ne 'preserve desktop daemon state') {
        throw 'The desktop upgrade removed daemon state.'
    }
} else {
    Invoke-Chocolatey -ArgumentList @('install', 'octelium-desktop', '--version', $version, '--source', $PackageDir, '-y', '--no-progress')
}

$installDir = Test-DesktopInstallation -ExpectedVersion $version
Invoke-Chocolatey -ArgumentList @('uninstall', 'octelium-desktop', '-y', '--no-progress')

for ($attempt = 0; $attempt -lt 30; $attempt++) {
    if ($null -eq (Get-Service -Name OcteliumDaemon -ErrorAction SilentlyContinue)) { break }
    Start-Sleep -Seconds 1
}
if ($null -ne (Get-Service -Name OcteliumDaemon -ErrorAction SilentlyContinue) -or @(Get-DesktopRegistration).Count -ne 0) {
    throw 'The desktop service or MSI registration still exists after uninstall.'
}
foreach ($filename in @('octelium-desktop.exe', 'octelium-desktop-daemon.exe', 'wireguard.dll', 'wintun.dll', 'install-daemon.ps1')) {
    if (Test-Path -LiteralPath (Join-Path $installDir $filename)) {
        throw "Desktop file remains after uninstall: $filename"
    }
}

Remove-Item -LiteralPath $sentinelPath -Force -ErrorAction SilentlyContinue
Write-Output 'Desktop Chocolatey installation tests passed.'
