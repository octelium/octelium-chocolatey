$ErrorActionPreference = 'Stop'

$arch = (Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' -Name PROCESSOR_ARCHITECTURE).PROCESSOR_ARCHITECTURE

if ($arch -eq 'ARM64') {
    $url  = "https://github.com/octelium/octelium-desktop/releases/download/v0.2.8/octelium-desktop-windows-arm64-Octelium.Desktop_0.2.8_arm64_en-US.msi"
    $hash = "b2e88f806e0b031866ffb2b1db4734f496e7baba1be9444cf549065f0b9414c8"
} elseif ($arch -eq 'AMD64') {
    $url  = "https://github.com/octelium/octelium-desktop/releases/download/v0.2.8/octelium-desktop-windows-amd64-Octelium.Desktop_0.2.8_x64_en-US.msi"
    $hash = "7f977d9a4f47fb1742df9dd5bb57f7c4c2fdda21438e894c1972cf451188410c"
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
