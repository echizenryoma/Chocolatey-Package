$ErrorActionPreference = 'Stop'

$PackageName = 'mobaxterm'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
Remove-Item $InstallationPath -Recurse -Force | Out-Null
Uninstall-BinFile -Name 'MobaXTerm'