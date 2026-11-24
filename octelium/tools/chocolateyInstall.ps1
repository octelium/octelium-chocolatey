$ErrorActionPreference = 'Stop'

$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ($arch -eq 'arm64') {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.52.0/octelium-0.52.0-arm64.msi"
    $hashOctelium   = "bfb26aa58e17c94220f6a5638f120d131f21738941744416b3ecdf8524e739af"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.52.0/octeliumctl-0.52.0-arm64.msi"
    $hashOcteliumctl= "774e4e68b7f32cf35d06aa1051fcf588e6274252f332111049a2a78810e97f50"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.52.0/octops-0.52.0-arm64.msi"
    $hashOctops     = "1e7734950546bd86ec900d665c2f65331a6be0fd73f72c997d5ae4e5340305d9"
} else {
    $urlOctelium    = "https://github.com/octelium/octelium/releases/download/v0.52.0/octelium-0.52.0-amd64.msi"
    $hashOctelium   = "88a516f1fdd05a79717f0766120fdb546e6df3da0712973ea5b0d164ebd227af"
    $urlOcteliumctl = "https://github.com/octelium/octelium/releases/download/v0.52.0/octeliumctl-0.52.0-amd64.msi"
    $hashOcteliumctl= "cbce87cf6e0e129dd29c25a60193a9eed84b895623e0ee85f2727de49d6ca50d"
    $urlOctops      = "https://github.com/octelium/octelium/releases/download/v0.52.0/octops-0.52.0-amd64.msi"
    $hashOctops     = "d6753c912cdd38b8a1835fbebd048af66edcbdf0178fe36b52a2a3a1b6323df1"
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