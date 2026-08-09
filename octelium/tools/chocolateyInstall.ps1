$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.39.0/octelium-0.39.0-arm64.msi"
    $hashOctelium   = "527967d9fd615def1fa344c9e5751b5a7b63cac10eccce161af1d21207287078"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.39.0/octeliumctl-0.39.0-arm64.msi"
    $hashOcteliumctl= "dcee549dab80da4776a29967808de8552d4bf2d2d3b1509da4c8f2ab9d9767a1"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.39.0/octops-0.39.0-arm64.msi"
    $hashOctops     = "5cbd4b80da5963bafc9055d81136ca9b60a8035a576ecda4a53c88b80c41c9de"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.39.0/octelium-0.39.0-amd64.msi"
    $hashOctelium   = "3431b63d501859da748d8ce57a1a3906a3c63b0d6b0e233262a0aa7245d72c77"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.39.0/octeliumctl-0.39.0-amd64.msi"
    $hashOcteliumctl= "727b31283846d71c9972d69eefbdd9e4f57e29de6ab82e2efaf4c27ca30a8c37"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.39.0/octops-0.39.0-amd64.msi"
    $hashOctops     = "46486c010ea1523c4210522296d4b8935ef284d0101f1e9c1ca49f3ffae05c64"
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