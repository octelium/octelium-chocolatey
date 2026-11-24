$ErrorActionPreference = 'Stop'

$arch = (Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' -Name PROCESSOR_ARCHITECTURE).PROCESSOR_ARCHITECTURE

if ($arch -eq 'ARM64') {
    $url  = "https://github.com/octelium/octelium-desktop/releases/download/v0.6.0/octelium-desktop-windows-arm64-Octelium.Desktop_0.6.0_arm64_en-US.msi"
    $hash = "660947d89faa97848e27ec03d7d1e1c5f54663dcf43478b4d0744522e6cf8614"
} elseif ($arch -eq 'AMD64') {
    $url  = "https://github.com/octelium/octelium-desktop/releases/download/v0.6.0/octelium-desktop-windows-amd64-Octelium.Desktop_0.6.0_x64_en-US.msi"
    $hash = "e511e9a0e55633a30659f0a284f7c6bba62ae78fd52e35f9d196cb9e318fd5ab"
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
