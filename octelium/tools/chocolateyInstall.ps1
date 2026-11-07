$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.50.0/octelium-0.50.0-arm64.msi"
    $hashOctelium   = "8b58366582d1003934d65306cc08d7498622f1323a158e3275640c5e0b226ace"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.50.0/octeliumctl-0.50.0-arm64.msi"
    $hashOcteliumctl= "f8139653c64bc590d5e6b728bc8ffc719681aa81da6594b58836a543b5e2f0de"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.50.0/octops-0.50.0-arm64.msi"
    $hashOctops     = "d3ce94a8651b0f1707d25b34cfcd123f9aa29466c5c7dfbc2adf0a58db41f2bb"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.50.0/octelium-0.50.0-amd64.msi"
    $hashOctelium   = "e40f2890854d58db9ac9af918dcb84bb303ee967a0878bfdb01b9adc4ba47b26"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.50.0/octeliumctl-0.50.0-amd64.msi"
    $hashOcteliumctl= "fd731c7273f9a82b0a3ff46ca0c2e62e7ba9b032b39fba9bc9ed1c1f7fd65b63"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.50.0/octops-0.50.0-amd64.msi"
    $hashOctops     = "d46f1a8efec8a7a6339e8b92e25c65d2370d26a3a083212712ebcb2d43e71c8b"
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