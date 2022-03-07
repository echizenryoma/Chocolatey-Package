$ErrorActionPreference = 'Stop';

$PackageName = 'nvm'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$nvm = Get-Item $(Join-Path $InstallationPath "${PackageName}.exe")
& $nvm off
