$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Remove-Item -Path "$toolsDir\*.exe" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$toolsDir\*.dll" -Force -ErrorAction SilentlyContinue