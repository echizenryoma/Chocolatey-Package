$PackageName = 'InkScape'
$InstallationPath = Join-Path $(Get-ToolsLocation) $($PackageName.ToLower())

Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore
Uninstall-BinFile -Name $($PackageName.ToLower())

$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "${PackageName}.lnk"
Remove-Item $LinkPath -Force -ErrorAction Ignore