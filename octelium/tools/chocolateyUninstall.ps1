$ErrorActionPreference = 'Stop'
$packageArgs = @{
    packageName = 'octelium'
    fileType    = 'msi'
    silentArgs  = "/quiet /norestart"
}

Uninstall-ChocolateyPackage @packageArgs
Uninstall-ChocolateyPackage -PackageName 'octeliumctl' -FileType 'msi' -SilentArgs "/quiet /norestart"
Uninstall-ChocolateyPackage -PackageName 'octops' -FileType 'msi' -SilentArgs "/quiet /norestart"