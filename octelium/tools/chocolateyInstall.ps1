$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.51.0/octelium-0.51.0-arm64.msi"
    $hashOctelium   = "7fa85b11aaafff7d74592e4d57fb14d305562191e1d3f82006ff334ba518b54c"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.51.0/octeliumctl-0.51.0-arm64.msi"
    $hashOcteliumctl= "d930003b50f080935324b49d573316b2c7a60d6605849a0bc4cd7e419dce58aa"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.51.0/octops-0.51.0-arm64.msi"
    $hashOctops     = "d59af8aac021e21390f65729b22ef09c0b1e388f22c8a25fd09cd98fbe57baf4"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.51.0/octelium-0.51.0-amd64.msi"
    $hashOctelium   = "e5a44f90c507a23ad2e729aea5ff479234a0b11e0175c502840b57dad9f18768"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.51.0/octeliumctl-0.51.0-amd64.msi"
    $hashOcteliumctl= "622955582a1aec918c2e7a9f405be544ad7cf4af26189c501139b79297ef1c19"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.51.0/octops-0.51.0-amd64.msi"
    $hashOctops     = "4ef201e5e7c9d8f83ec40c8e61ea67741ea83d523b6659175f39af5869cfe651"
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