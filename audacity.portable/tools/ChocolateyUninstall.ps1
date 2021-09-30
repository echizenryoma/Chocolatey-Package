$PackageName = 'audacity'

Uninstall-BinFile -Name "${PackageName}"

$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore