$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.38.0/octelium-0.38.0-arm64.msi"
    $hashOctelium   = "584fb5b408b28664b306bab7f62fd4e3b1637f691f1e11821fdc36e8d9efb833"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.38.0/octeliumctl-0.38.0-arm64.msi"
    $hashOcteliumctl= "c1578fbc80006c2a1267fab2c344192ba1a648be90b32cd97b06d655c373649d"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.38.0/octops-0.38.0-arm64.msi"
    $hashOctops     = "8020a4ae090651d5a3ee0e9a06775bb2dd1b3c4c4068895c1b7360ee5d906906"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.38.0/octelium-0.38.0-amd64.msi"
    $hashOctelium   = "552b93b36525ff1767b987699e75b2d5fdd411318c53d4b82ed00810ffe16c43"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.38.0/octeliumctl-0.38.0-amd64.msi"
    $hashOcteliumctl= "3df7553b3434f779cf0162d49546c5d591c230f323682fef2c8fadb7628f304b"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.38.0/octops-0.38.0-amd64.msi"
    $hashOctops     = "bc0ebdb0ca2438612e8586f6e559f8873192c5054eff92cf3da85c3e106be1f2"
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