$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.34.0/octelium-0.34.0-arm64.msi"
    $hashOctelium   = "7ca18ce04b6eb21d425c77e8ad50f2fd5419eed3ebccd802568d07c56e510a80"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.34.0/octeliumctl-0.34.0-arm64.msi"
    $hashOcteliumctl= "84add4bb5c622c3f48baa34a32f6eb07589652316de89aac612445a0169ac5a3"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.34.0/octops-0.34.0-arm64.msi"
    $hashOctops     = "6b7f1104875db3587d89a34366c55d106c37c98bd4bb845e897d8d7ee3a4bf32"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.34.0/octelium-0.34.0-amd64.msi"
    $hashOctelium   = "b9dbba954c70b861adc9410c42fc0f631d498910c57d8e243de7aa9a43d1957d"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.34.0/octeliumctl-0.34.0-amd64.msi"
    $hashOcteliumctl= "bcb793487c637afc23f3d5ed4c2af1e7da6a49443c73a0e6197f3370dfd14107"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.34.0/octops-0.34.0-amd64.msi"
    $hashOctops     = "ab94776d201852a6a73e77717e506364643b200c3c03a65b373379c3bc01081d"
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