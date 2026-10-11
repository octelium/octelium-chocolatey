$ErrorActionPreference = 'Stop'

$arch = (Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' -Name PROCESSOR_ARCHITECTURE).PROCESSOR_ARCHITECTURE

if ($arch -eq 'ARM64') {
    $url  = "https://github.com/octelium/octelium-desktop/releases/download/v0.2.6/octelium-desktop-windows-arm64-Octelium.Desktop_0.2.6_arm64_en-US.msi"
    $hash = "b8f456d06ba01366468abc297dcb128efd0d387be93907f3294b74195580f10f"
} elseif ($arch -eq 'AMD64') {
    $url  = "https://github.com/octelium/octelium-desktop/releases/download/v0.2.6/octelium-desktop-windows-amd64-Octelium.Desktop_0.2.6_x64_en-US.msi"
    $hash = "d84d0515829c378d4915a358210cdbd7325b77a91e5064bd3efb342083166e4e"
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
