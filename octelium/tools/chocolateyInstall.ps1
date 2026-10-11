$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.45.0/octelium-0.45.0-arm64.msi"
    $hashOctelium   = "943c23d021545737a1c9466871f99152d3fe2200bdf6147d229e95583ddf7b78"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.45.0/octeliumctl-0.45.0-arm64.msi"
    $hashOcteliumctl= "43cb343fbc729e0eaca77f5f6e2923606108548c70a01e0a11d5b288339caf76"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.45.0/octops-0.45.0-arm64.msi"
    $hashOctops     = "4521cf0a691c6a3a45727825a22b9dc4e176ccaa162656376651dc809fcd8d02"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.45.0/octelium-0.45.0-amd64.msi"
    $hashOctelium   = "88e34155b71e431eed867f1e0b7b03bcad40a41f8cc9d5a6e11f31f0ae3a7e3c"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.45.0/octeliumctl-0.45.0-amd64.msi"
    $hashOcteliumctl= "93d7601eaacb62f8f609237c2ad9e5225265243e78448469c8b9ecb5958a3346"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.45.0/octops-0.45.0-amd64.msi"
    $hashOctops     = "1a2c70081ca7c257f9e1c74ca5f5a8f7855dc1a00aec286695299084292f8a2a"
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