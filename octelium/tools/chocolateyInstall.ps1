$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.49.0/octelium-0.49.0-arm64.msi"
    $hashOctelium   = "13a6508bd7b66eb1b3a723eafd618fa57f5c314ef116bc377e89088505500acb"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.49.0/octeliumctl-0.49.0-arm64.msi"
    $hashOcteliumctl= "520a05ebe320c3d19086efa73bdda31e78097c1e7fcce90166e6fdeab4bc7f7d"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.49.0/octops-0.49.0-arm64.msi"
    $hashOctops     = "ffd6981d5e1af25ae357e623bd48011d6f013d7d425b70d764018908c928914f"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.49.0/octelium-0.49.0-amd64.msi"
    $hashOctelium   = "4b67ad03fab0f75f5af42d8b72862f115121d5a9428eed5a4c3d53e41b7bcb4d"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.49.0/octeliumctl-0.49.0-amd64.msi"
    $hashOcteliumctl= "ff41390347e5313ea4608797b776041d46ee702af1282625e32c81163f543070"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.49.0/octops-0.49.0-amd64.msi"
    $hashOctops     = "abc5332c9d1837edc06f213f64f12da9b7af2f05f2976a29b4e1aff44ced834b"
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