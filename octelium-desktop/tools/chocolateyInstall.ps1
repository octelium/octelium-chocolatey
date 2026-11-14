$ErrorActionPreference = 'Stop'

$arch = (Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' -Name PROCESSOR_ARCHITECTURE).PROCESSOR_ARCHITECTURE

if ($arch -eq 'ARM64') {
    $url  = "https://github.com/octelium/octelium-desktop/releases/download/v0.5.0/octelium-desktop-windows-arm64-Octelium.Desktop_0.5.0_arm64_en-US.msi"
    $hash = "b8d31c3eb14d952138b1b8e0e14f0b4be890df3759ebde20fd44c4a0f1dec34b"
} elseif ($arch -eq 'AMD64') {
    $url  = "https://github.com/octelium/octelium-desktop/releases/download/v0.5.0/octelium-desktop-windows-amd64-Octelium.Desktop_0.5.0_x64_en-US.msi"
    $hash = "725fe77c615b56109a4900d92ab65e68fdde505afae05147ebef2a5c5f518e42"
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
