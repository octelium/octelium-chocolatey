$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.31.0/octelium-0.31.0-arm64.msi"
    $hashOctelium   = "25e7103ecfe8cf7128e7d21d5c7f8e12acbd6b78e3f093ae5a2b7636ef3a25cc"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.31.0/octeliumctl-0.31.0-arm64.msi"
    $hashOcteliumctl= "ca73c9a40d2644b8eb41fc24e662291dbb1ea0161aad0fc7bb73bb9edda70130"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.31.0/octops-0.31.0-arm64.msi"
    $hashOctops     = "2156df2e251c1231d54dd93432a7ff255ee1b2ea00f2d3ccc3c03184a9ccc882"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.31.0/octelium-0.31.0-amd64.msi"
    $hashOctelium   = "562933170615d3a344395a271abbc1aa33d67f779b761f9b37dc0ba198e7eff9"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.31.0/octeliumctl-0.31.0-amd64.msi"
    $hashOcteliumctl= "39cb89585eb4df832cb85b678b668722edb7a75a8f8d6caf0b361de998fe18e3"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.31.0/octops-0.31.0-amd64.msi"
    $hashOctops     = "b6499b9091ade43e999bd03a0d72f639a41abf16f426cf6010ffe92ce5dce740"
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