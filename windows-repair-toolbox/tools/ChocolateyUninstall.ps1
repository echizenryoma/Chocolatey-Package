$PackageName = 'windows-repair-toolbox'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore
Uninstall-BinFile -Name 'Windows_Repair_Toolbox'
