$ErrorActionPreference = 'Stop'

$arch = (Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' -Name PROCESSOR_ARCHITECTURE).PROCESSOR_ARCHITECTURE

if ($arch -eq 'ARM64') {
    $url  = "https://github.com/octelium/octelium-desktop/releases/download/v0.3.0/octelium-desktop-windows-arm64-Octelium.Desktop_0.3.0_arm64_en-US.msi"
    $hash = "e40f81d07d9311c2f6c1d9d496176cc2eac06f2674b59c0f9f00b1f9f86aca43"
} elseif ($arch -eq 'AMD64') {
    $url  = "https://github.com/octelium/octelium-desktop/releases/download/v0.3.0/octelium-desktop-windows-amd64-Octelium.Desktop_0.3.0_x64_en-US.msi"
    $hash = "1f3c7dead739ea3c13c4b6fec14a239cf7644e5d18afeb67e4b4ac577f424113"
} else {
    throw 'Octelium Desktop requires an x64 or ARM64 version of Windows.'
}

$packageArgs = @{
    packageName    = 'octelium-desktop'
    fileType       = 'msi'
    silentArgs     = "/quiet /norestart"
    validExitCodes = @(0, 3010, 1641)
    softwareName   = 'Octelium Desktop'
    url64bit       = $url
    checksum64     = $hash
    checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs
