$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.40.0/octelium-0.40.0-arm64.msi"
    $hashOctelium   = "3cd12360dd488a93a96c4cb1f31fc4011f8964726eeab0a81c8cbd7648d029b1"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.40.0/octeliumctl-0.40.0-arm64.msi"
    $hashOcteliumctl= "8ba1700be772ff4e133eade9bf0aa96126482bd83134c52a370b40f2f246d8fb"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.40.0/octops-0.40.0-arm64.msi"
    $hashOctops     = "c7decd8ee7c479f886ef52d324ea86ddce14ba83b322b3aba0c75b588ed18b94"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.40.0/octelium-0.40.0-amd64.msi"
    $hashOctelium   = "154b6c72096520c88e9f6fcccd33f269d9417b5fa0e12e8bc625a6d50322790a"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.40.0/octeliumctl-0.40.0-amd64.msi"
    $hashOcteliumctl= "281450bf61c12379e583822a3a0332589802b66e681b7227d7617fbe2371b5a7"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.40.0/octops-0.40.0-amd64.msi"
    $hashOctops     = "c25643174304fe7d0411d6116a6cb11d33a26996fbbe523483d0423a78475c21"
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