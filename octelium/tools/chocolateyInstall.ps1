$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.29.0/octelium-0.29.0-arm64.msi"
    $hashOctelium   = "2abd14141210d4c37aa13adc832e5e4c8ae5e5c4d4a5a03f3c4fbc84a82dd1e5"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.29.0/octeliumctl-0.29.0-arm64.msi"
    $hashOcteliumctl= "898f421d39bf06d9dc914da73cb78e002767eec3991dfec4d7a73f42e2ad2f9b"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.29.0/octops-0.29.0-arm64.msi"
    $hashOctops     = "6ae532df7a1d377b4cef98c6df044fde9176df2de7ebb81ebf348536ca1d8358"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.29.0/octelium-0.29.0-amd64.msi"
    $hashOctelium   = "434c47c402f675a306d1a02b49552004337defdf429ac87ff7a96c2f34b7e756"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.29.0/octeliumctl-0.29.0-amd64.msi"
    $hashOcteliumctl= "424a722282b1748eb12ec2c59582b5d5a16ccc6d18b3fc68718f06e643283a68"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.29.0/octops-0.29.0-amd64.msi"
    $hashOctops     = "095f70d71e55068512b6209221e65708018fc8c804a808a973dbc9d1d9e3d99e"
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