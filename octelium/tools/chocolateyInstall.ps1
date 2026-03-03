$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.27.0/octelium-0.27.0-arm64.msi"
    $hashOctelium   = "a852c75576de0993f907b528f479aa6af5b75c50b69a87a9cef10807f9d30e73"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.27.0/octeliumctl-0.27.0-arm64.msi"
    $hashOcteliumctl= "e8a5bb820601f837b5eb5c4e3a92e7f61d593eed7bf21592e035f61ffcfba948"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.27.0/octops-0.27.0-arm64.msi"
    $hashOctops     = "82ce1e1fba19dc4b46d1878102dc5241f99f3911d1a0e1a54c409971c8e337eb"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.27.0/octelium-0.27.0-amd64.msi"
    $hashOctelium   = "c4b699c56dcd4964aaa68989628de13ae7ac81e5dbb014239ed168aac168f712"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.27.0/octeliumctl-0.27.0-amd64.msi"
    $hashOcteliumctl= "e243ca48cd486a3ec7a4445aa8fe391b7dd0fa0b3aaaa877b645fca377cc4360"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.27.0/octops-0.27.0-amd64.msi"
    $hashOctops     = "00a9bad3cffea5005fff9ebff10442bb587fb3a5c966e9f3273b592adcba03da"
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