$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.32.0/octelium-0.32.0-arm64.msi"
    $hashOctelium   = "1414d6a5a5bdcd21a80d0e9dee43359e610e4efeda4c9f546020954bc91b5095"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.32.0/octeliumctl-0.32.0-arm64.msi"
    $hashOcteliumctl= "f4f169ef38acb9f0b7d689030c6063f5640f69f4f1e187d49002439dd4c181f4"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.32.0/octops-0.32.0-arm64.msi"
    $hashOctops     = "c327b652d4f3710883c6d80c62e2f979d90bbc54262eee03705e9875e0ed6f78"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.32.0/octelium-0.32.0-amd64.msi"
    $hashOctelium   = "57f7ef5313defef5748f41451a16c22a581275fb24308bc6e4b95401aa997470"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.32.0/octeliumctl-0.32.0-amd64.msi"
    $hashOcteliumctl= "472463ce8557300528e33d0f13a419ea4e85bf50ca448583ebcd78055f52e386"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.32.0/octops-0.32.0-amd64.msi"
    $hashOctops     = "ea42a08aa69ab0741c634f39fe041e7281a3302b990192dd8a82d299b6140289"
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