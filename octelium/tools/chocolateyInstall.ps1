$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.33.0/octelium-0.33.0-arm64.msi"
    $hashOctelium   = "5c10a382985d9f9fd46234c7e39c063b4e56612c0220c0d09015066a04b95ee2"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.33.0/octeliumctl-0.33.0-arm64.msi"
    $hashOcteliumctl= "85ed35b5b2f3df0b661420e010908b1c93ef99b6f5139dfed1ab739dd6251dd8"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.33.0/octops-0.33.0-arm64.msi"
    $hashOctops     = "109fe8b347aed10fca5aebe4f59f22520146a75a2b3d1aa3e203b8079a8a12d8"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.33.0/octelium-0.33.0-amd64.msi"
    $hashOctelium   = "383ff9e075e484f224272c89488ac030028059e6612937134f7c65c2979010ad"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.33.0/octeliumctl-0.33.0-amd64.msi"
    $hashOcteliumctl= "54bc4859fff4fb813e807eb00d74ca7ff39eed967b70b22ce0aaad81eaf6cb49"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.33.0/octops-0.33.0-amd64.msi"
    $hashOctops     = "9c214c4591239ccea1363439d1a3e961a384f40539ebe72247815f27deaf6db8"
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