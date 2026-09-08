$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.42.0/octelium-0.42.0-arm64.msi"
    $hashOctelium   = "81021c01a64d6d69712d5a2e669facfa599ab1c6fb7b35f8f55b3db5377240b1"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.42.0/octeliumctl-0.42.0-arm64.msi"
    $hashOcteliumctl= "f8202be1efe4997a0f9066bef8f7c637d4f46d0c8fed4fe86c5d9f995098399b"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.42.0/octops-0.42.0-arm64.msi"
    $hashOctops     = "c2389af9947cceb064bb944faa99d2b213d031fef0cb33fca403f3a0712b8c71"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.42.0/octelium-0.42.0-amd64.msi"
    $hashOctelium   = "0aad2f127e9c34dc067a970f52f4ed3d145ac6dbf9b7f2258fd772d9b9c1d33c"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.42.0/octeliumctl-0.42.0-amd64.msi"
    $hashOcteliumctl= "72dfabd426633f956fa055c5e03c803be9872cf0076cfeb744c7d120fd42f588"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.42.0/octops-0.42.0-amd64.msi"
    $hashOctops     = "a842ab03168fe349e274d41b0c61baf6ae9566245c2767f60f62bb0d48225ddd"
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