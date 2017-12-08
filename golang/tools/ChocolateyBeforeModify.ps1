$ErrorActionPreference = 'Stop'

$InstallationPath = Get-ToolsLocation
$GOROOT = Join-Path $InstallationPath 'go'
Get-ChildItem -Path $GOROOT -exclude 'opt' |
    Remove-Item -Recurse -Force | Out-Null 
