$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.35.0/octelium-0.35.0-arm64.msi"
    $hashOctelium   = "8da144bea482b5e384812ecec0ac550fa9604ae732e049bbddee4efeb52645ce"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.35.0/octeliumctl-0.35.0-arm64.msi"
    $hashOcteliumctl= "84d3928a249536fd3addc6b219a37fe04fd043647793edb2bee8f1d4fc9b05da"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.35.0/octops-0.35.0-arm64.msi"
    $hashOctops     = "6858c1ec0a5dbf727ac2b6c1c62e670904d52b55cd77ddc1058cf993d27bafe9"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.35.0/octelium-0.35.0-amd64.msi"
    $hashOctelium   = "1610b8382d2e741a1ba62109bdbded28b7f486106a79e89df318bffc37268984"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.35.0/octeliumctl-0.35.0-amd64.msi"
    $hashOcteliumctl= "d2a5402b9086a6f594a8f13ecd03544ad86a8a580aadb7034f2577a2a0e1f43e"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.35.0/octops-0.35.0-amd64.msi"
    $hashOctops     = "62c55815896c7dcec56430044c724d64335e41b89cae32cffe4aafac98435021"
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