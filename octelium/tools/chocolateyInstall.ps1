$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.30.0/octelium-0.30.0-arm64.msi"
    $hashOctelium   = "4176c4a573d4e7ad5e0bc9f20c08cf3083724febbd03696679f858aa41defce9"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.30.0/octeliumctl-0.30.0-arm64.msi"
    $hashOcteliumctl= "698fdba6507a3e612a8ab911f7bb37e0b36fe768612a40dc95ffd092dace49c1"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.30.0/octops-0.30.0-arm64.msi"
    $hashOctops     = "57a7cb6aa41b8551c221e7267d4ff4e67818a4fba2f00aa25c2da5fcd722552c"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.30.0/octelium-0.30.0-amd64.msi"
    $hashOctelium   = "0a1cfc92a1668735e4404378407c64726649933e020776f4db5bad0b1159129e"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.30.0/octeliumctl-0.30.0-amd64.msi"
    $hashOcteliumctl= "52f6e01be77c24eebd2dc001601d519b80856a326d1b0afc24892f8fc2822715"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.30.0/octops-0.30.0-amd64.msi"
    $hashOctops     = "53bdd32df8b247479b923729ba4108cae6eea2e2674874f5d508a73ec1d63026"
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