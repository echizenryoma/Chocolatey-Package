$PackageName = 'ChocolateyGUI'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore

Uninstall-BinFile -Name "ChocolateyGui"
Uninstall-BinFile -Name "ChocolateyGuiCli"
