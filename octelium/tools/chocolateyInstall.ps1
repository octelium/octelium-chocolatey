$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.46.0/octelium-0.46.0-arm64.msi"
    $hashOctelium   = "2f84b7e10abc78ba93458495bd51ecbad5a705fcf7fb199b805bafc8781cc7bd"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.46.0/octeliumctl-0.46.0-arm64.msi"
    $hashOcteliumctl= "1b5e46f189725683faea6f058d30a6bbbd58382a7ed115281b8bbd00a2c7de8e"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.46.0/octops-0.46.0-arm64.msi"
    $hashOctops     = "90f63a83fe7d0a7a75df8edd52fc53d201021d464a2896a511856639c4c3d15c"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.46.0/octelium-0.46.0-amd64.msi"
    $hashOctelium   = "d06d17ab02450f10a0ee53a3ed9237e326cae8c5465f812247fea7fbdb4fb24e"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.46.0/octeliumctl-0.46.0-amd64.msi"
    $hashOcteliumctl= "0e98fa6be21db689e717449e1c6e79f453e23327621c2a7d8cc55463ef78c0ae"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.46.0/octops-0.46.0-amd64.msi"
    $hashOctops     = "376d3e30a4bee4982b8389a85f876e6c9d2a8d563064d6eda43a0e3b6e4a4d14"
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