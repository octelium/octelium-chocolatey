$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.36.0/octelium-0.36.0-arm64.msi"
    $hashOctelium   = "c9c80b01f020273c964f75da8a5b377e158d9b8a66dd9ff73196f210b2f62508"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.36.0/octeliumctl-0.36.0-arm64.msi"
    $hashOcteliumctl= "d1339c24fa44c9d1a471806bdac83843ca9cd79026656e1f763b425717936be1"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.36.0/octops-0.36.0-arm64.msi"
    $hashOctops     = "a5c8ce360440d4722fa87c7661fd717c5fe4d05179b3190fad9c8c5563698e31"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.36.0/octelium-0.36.0-amd64.msi"
    $hashOctelium   = "683c65b4a4b0a40abbd3a59c17deba1329039967e387804dbfe5b9d6927770f1"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.36.0/octeliumctl-0.36.0-amd64.msi"
    $hashOcteliumctl= "53242e9bab78195c39623fe37904ea1b8d34ed23791685bc1aebcc2c4b0d1b77"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.36.0/octops-0.36.0-amd64.msi"
    $hashOctops     = "70acb7b675f67120788343106c623b7d38e33332db758f78a9b2b22c2aaa1721"
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