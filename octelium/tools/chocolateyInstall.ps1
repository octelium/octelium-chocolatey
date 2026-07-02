$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.37.0/octelium-0.37.0-arm64.msi"
    $hashOctelium   = "308e528dd2839cc95c9b516b61b40881d2cd174e300ddbc408773a1a9f268080"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.37.0/octeliumctl-0.37.0-arm64.msi"
    $hashOcteliumctl= "e6114fe7d0cebd412e434753d01ab07f202e3141006a70a279c5c20884af17d3"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.37.0/octops-0.37.0-arm64.msi"
    $hashOctops     = "1e496d970b9c14f6a2c04b8abdcd2d9be092a96867494fa504bc8e7d0f543af5"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.37.0/octelium-0.37.0-amd64.msi"
    $hashOctelium   = "bbc9fe9ce1f1948aea7daf8d065d01ac274c0fe38cb74163a021dac0cd527537"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.37.0/octeliumctl-0.37.0-amd64.msi"
    $hashOcteliumctl= "3f38f93a3ad2ee2ca306621d1b5418a307ecc566173cdd09bef01c25f0addf22"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.37.0/octops-0.37.0-amd64.msi"
    $hashOctops     = "4f6b30f14ec2468e06468e3f80cc8dd8fb1b47458108cb868bc300d9ab775c8c"
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