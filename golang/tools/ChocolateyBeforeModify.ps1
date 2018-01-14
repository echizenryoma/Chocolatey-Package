$ErrorActionPreference = 'Stop'

$InstallationPath = Join-Path $(Get-ToolsLocation) 'go'
$null = Get-ChildItem -Path $InstallationPath -exclude 'opt' | Remove-Item -Recurse -Force -ErrorAction Ignore
