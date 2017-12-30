$ErrorActionPreference = 'Stop'

$InstallationPath = Join-Path $(Get-ToolsLocation) 'go'
Get-ChildItem -Path $InstallationPath -exclude 'opt' | Remove-Item -Recurse -Force -ErrorAction Ignore | Out-Null 
