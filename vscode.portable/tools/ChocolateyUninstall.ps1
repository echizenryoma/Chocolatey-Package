$ErrorActionPreference = 'Stop';

$InstallationPath = Join-Path $(Get-ToolsLocation) 'vscode'
Remove-Item $InstallationPath -Recurse -Force | Out-Null
Uninstall-BinFile -Name 'Code'