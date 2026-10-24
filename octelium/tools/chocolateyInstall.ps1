$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.47.0/octelium-0.47.0-arm64.msi"
    $hashOctelium   = "499e5791966c09168b5301756d8d25e38c650b4405e2ebcdb77b81dc00dc9607"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.47.0/octeliumctl-0.47.0-arm64.msi"
    $hashOcteliumctl= "d6a352ee18d08423d320346cf285b39846e1f4a99fe8da496bd33d59049f8055"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.47.0/octops-0.47.0-arm64.msi"
    $hashOctops     = "77f22a93a29f4a5f4dda39380a02a527508c505e0d755647a48777109da65340"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.47.0/octelium-0.47.0-amd64.msi"
    $hashOctelium   = "423ee24203bc0781fb63e59288461e820507a31fb30f1f09eb8dc0d5080663e1"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.47.0/octeliumctl-0.47.0-amd64.msi"
    $hashOcteliumctl= "b0f7b16ed9de2588cb02f2ef0ec082591a2b1a3f5e2075fd05fa2f5735447da8"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.47.0/octops-0.47.0-amd64.msi"
    $hashOctops     = "16757593fcb2d035581739c65587d3410cdeb05e6c363bd5b6bdde52fcb25395"
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