$ErrorActionPreference = 'Stop';

$PackageName = 'golang'
$InstallationPath = Get-ToolsLocation

$GOROOT = Join-Path $InstallationPath 'go'
$GOPATH = Join-Path $GOROOT 'opt'
Get-ChildItem -Path $GOROOT -exclude 'opt' |
Remove-Item -Recurse -Force | Out-Null 
