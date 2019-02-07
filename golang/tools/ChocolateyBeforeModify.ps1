$ErrorActionPreference = 'Stop'

$PackageName = 'go'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$null = Get-ChildItem -Path $InstallationPath -exclude 'opt' | Remove-Item -Recurse -Force -ErrorAction Ignore
