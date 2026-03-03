$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/${TAG}/octelium-${CLEAN_VERSION}-arm64.msi"
    $hashOctelium   = "${SHA_OCTELIUM_MSI_ARM64}"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/${TAG}/octeliumctl-${CLEAN_VERSION}-arm64.msi"
    $hashOcteliumctl= "${SHA_OCTELIUMCTL_MSI_ARM64}"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/${TAG}/octops-${CLEAN_VERSION}-arm64.msi"
    $hashOctops     = "${SHA_OCTOPS_MSI_ARM64}"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/${TAG}/octelium-${CLEAN_VERSION}-amd64.msi"
    $hashOctelium   = "${SHA_OCTELIUM_MSI_AMD64}"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/${TAG}/octeliumctl-${CLEAN_VERSION}-amd64.msi"
    $hashOcteliumctl= "${SHA_OCTELIUMCTL_MSI_AMD64}"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/${TAG}/octops-${CLEAN_VERSION}-amd64.msi"
    $hashOctops     = "${SHA_OCTOPS_MSI_AMD64}"
}

$packageArgs = @{
    packageName    = 'octelium'
    fileType       = 'msi'
    silentArgs     = "/quiet /norestart"
    validExitCodes = @(0, 3010, 1641) # 3010 is 'Restart Required'
}

# Install each component
Install-ChocolateyPackage @packageArgs -Url $urlOctelium -Checksum $hashOctelium -ChecksumType 'sha256'
Install-ChocolateyPackage @packageArgs -Url $urlOcteliumctl -Checksum $hashOcteliumctl -ChecksumType 'sha256'
Install-ChocolateyPackage @packageArgs -Url $urlOctops -Checksum $hashOctops -ChecksumType 'sha256'