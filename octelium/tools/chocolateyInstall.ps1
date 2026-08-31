$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.41.0/octelium-0.41.0-arm64.msi"
    $hashOctelium   = "f8f7e47fbad120b977a1dc111740e057d74cdd131dfc26cb292ef945fd123345"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.41.0/octeliumctl-0.41.0-arm64.msi"
    $hashOcteliumctl= "809a336a47d12ae079ca1dd02e022cdf149d66ad587890ea6a3c24db226a6b5f"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.41.0/octops-0.41.0-arm64.msi"
    $hashOctops     = "655a6ef3064ca7737204b64971c3158833b7aa63cf90309ebad76bf4944cfa30"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.41.0/octelium-0.41.0-amd64.msi"
    $hashOctelium   = "d59578f0a7732bdd513dde88dea9ebd9b2a415d318c028458a07343cf2c44043"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.41.0/octeliumctl-0.41.0-amd64.msi"
    $hashOcteliumctl= "146f36d1bc13059c27e581ffd92e7ecba735f56a8ce6c01ebf69a6c889628b3b"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.41.0/octops-0.41.0-amd64.msi"
    $hashOctops     = "c88d79075966796b22f906bde09d80672e8000753abff1ad8eaffba79ca6fb83"
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