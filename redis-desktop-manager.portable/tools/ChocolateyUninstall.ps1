$PackageName = 'redis-desktop-manager'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore
Uninstall-BinFile -Name 'rdm'

$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "Redis Desktop Manager.lnk"
Remove-Item $LinkPath -Force -ErrorAction Ignore