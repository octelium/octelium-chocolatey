$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.43.0/octelium-0.43.0-arm64.msi"
    $hashOctelium   = "9cf21f040664dde2267090c39459cd544214c2ac838a776f0fcc51eb901ddefb"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.43.0/octeliumctl-0.43.0-arm64.msi"
    $hashOcteliumctl= "a8efd84af15494e307e59b7de3034a53a8563fedb52a9d3399ee7c0069c5b37e"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.43.0/octops-0.43.0-arm64.msi"
    $hashOctops     = "a503f672f3bd4d56299f72f8ca7d77034c84f91c64b36b632243f90f638f3257"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.43.0/octelium-0.43.0-amd64.msi"
    $hashOctelium   = "fb5e1b2dab2c8437d40f65de40c6635859b130dd109705a89006266a6cf94ce2"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.43.0/octeliumctl-0.43.0-amd64.msi"
    $hashOcteliumctl= "6306de06267bec40490c91c71f149953bf0cf1f3d33b3a5c1525ab14a8ea62da"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.43.0/octops-0.43.0-amd64.msi"
    $hashOctops     = "e18e9a3fd39b7d06bbb393ebd471cf855aae2545bb276f7ea63a96e098b6c56b"
}

$packageArgs = @{
    packageName    = 'octelium'
    fileType       = 'msi'
    silentArgs     = "/quiet /norestart"
    validExitCodes = @(0, 3010, 1641) # 3010 is 'Restart Required'
}

Install-ChocolateyPackage @packageArgs -Url $urlOctelium -Checksum $hashOctelium -ChecksumType 'sha256'
Install-ChocolateyPackage @packageArgs -Url $urlOcteliumctl -Checksum $hashOcteliumctl -ChecksumType 'sha256'
Install-ChocolateyPackage @packageArgs -Url $urlOctops -Checksum $hashOctops -ChecksumType 'sha256'