$ErrorActionPreference = 'Stop'

$arch = (Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' -Name PROCESSOR_ARCHITECTURE).PROCESSOR_ARCHITECTURE

if ($arch -eq 'ARM64') {
    $url  = "https://github.com/octelium/octelium-desktop/releases/download/v0.4.0/octelium-desktop-windows-arm64-Octelium.Desktop_0.4.0_arm64_en-US.msi"
    $hash = "228ed1a1820c29a2e66062454b32da1ee27ad0ff43081c4df03cf951e337f3eb"
} elseif ($arch -eq 'AMD64') {
    $url  = "https://github.com/octelium/octelium-desktop/releases/download/v0.4.0/octelium-desktop-windows-amd64-Octelium.Desktop_0.4.0_x64_en-US.msi"
    $hash = "b848d745587b095a9209b263c5a1a0e5f8f3ba8b9d3f46d146b2ac64402efe8c"
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
