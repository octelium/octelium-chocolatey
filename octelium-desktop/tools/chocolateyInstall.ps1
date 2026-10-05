$ErrorActionPreference = 'Stop'

$arch = (Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' -Name PROCESSOR_ARCHITECTURE).PROCESSOR_ARCHITECTURE

if ($arch -eq 'ARM64') {
    $url  = "https://github.com/octelium/octelium-desktop/releases/download/v0.2.5/octelium-desktop-windows-arm64-Octelium.Desktop_0.2.5_arm64_en-US.msi"
    $hash = "9ca59479498b0bb5bc30a3fc95d13681b2033077338abff92479064f952c1ec5"
} elseif ($arch -eq 'AMD64') {
    $url  = "https://github.com/octelium/octelium-desktop/releases/download/v0.2.5/octelium-desktop-windows-amd64-Octelium.Desktop_0.2.5_x64_en-US.msi"
    $hash = "1458b8ead80859d84b6c8984dc8156b8dd1cfedfce923bf566e2d800ed48344f"
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
