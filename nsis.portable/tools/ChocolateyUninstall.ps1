$PackageName = 'nsis'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

Remove-Item -Path $InstallationPath -Recurse -Force -ErrorAction SilentlyContinue
Uninstall-BinFile -Name 'makensis'