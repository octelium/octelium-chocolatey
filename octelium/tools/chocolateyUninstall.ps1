$ErrorActionPreference = 'Stop'

$msiNames = @('octelium', 'octeliumctl', 'octops')

foreach ($name in $msiNames) {
    Write-Output "Uninstalling $name..."
    
    Uninstall-ChocolateyPackage `
        -PackageName $name `
        -FileType 'msi' `
        -SilentArgs "/quiet /norestart"
}