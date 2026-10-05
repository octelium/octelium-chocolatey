$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.44.0/octelium-0.44.0-arm64.msi"
    $hashOctelium   = "1f2b3a31bc4938a790fc037cdcc30b1766bdbe7800cd32a475667a822e35ffa6"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.44.0/octeliumctl-0.44.0-arm64.msi"
    $hashOcteliumctl= "b2fca42369212260090d89d158db6750cf5d0a22a5a675d9ec6d402f4f6d6794"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.44.0/octops-0.44.0-arm64.msi"
    $hashOctops     = "0ee68d04fbfd09c2a5aae30c47f03537b45ab9f5ccc47979c76b552ded3fdb43"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.44.0/octelium-0.44.0-amd64.msi"
    $hashOctelium   = "702e8f4a7e3f1ccb7712ae05f63c65be2aab46a977fcbcd2379335d8801b102f"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.44.0/octeliumctl-0.44.0-amd64.msi"
    $hashOcteliumctl= "1c36691b73fd8142245fcb45485ccf7a2fa68eb87af307dce46600f9e1419376"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.44.0/octops-0.44.0-amd64.msi"
    $hashOctops     = "33b4a9f8771aa29847ecf7d066b04a4be4bea19ac2834a489e12e3994dd050cd"
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