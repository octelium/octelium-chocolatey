 = 'Stop'
 = "$(Split-Path -parent .MyCommand.Definition)"

 = if (:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }

if ( -eq 'arm64') {
        = "https://github.com/octelium/octelium/releases/download/v0.27.0/octelium-windows-arm64.zip"
       = "7d19194c5b5d66da3a70fd26823e2cac5973ff798db3f7ed5e030c90b0983a71"
     = "https://github.com/octelium/octelium/releases/download/v0.27.0/octeliumctl-windows-arm64.zip"
    = "bd6abff6b377cb704a32b2770fb1ef4cf2506bcede9784ebfe5a850854527be3"
          = "https://github.com/octelium/octelium/releases/download/v0.27.0/octops-windows-arm64.zip"
         = "53438519b2c0c2b7bc1689b853928b99fb85521e3b4a2592531a96c96c55c355"
} else {
        = "https://github.com/octelium/octelium/releases/download/v0.27.0/octelium-windows-amd64.zip"
       = "de409756a3616843341b8d6763762bd47b5d2926dbde372d2c7fe8d6cf12ea83"
     = "https://github.com/octelium/octelium/releases/download/v0.27.0/octeliumctl-windows-amd64.zip"
    = "7b20ba67f848f084577d36b8f5ba549454782691a8dbcee4a57eac6e265ad1da"
          = "https://github.com/octelium/octelium/releases/download/v0.27.0/octops-windows-amd64.zip"
         = "45745789151bc1bfec7090d1b82163e394015be89b5f05238c7d918e4e854680"
}

Install-ChocolateyZipPackage -PackageName 'octelium' `
    -Url  -Checksum  -ChecksumType 'sha256' `
    -UnzipLocation 

Install-ChocolateyZipPackage -PackageName 'octeliumctl' `
    -Url  -Checksum  -ChecksumType 'sha256' `
    -UnzipLocation 

Install-ChocolateyZipPackage -PackageName 'octops' `
    -Url  -Checksum  -ChecksumType 'sha256' `
    -UnzipLocation 