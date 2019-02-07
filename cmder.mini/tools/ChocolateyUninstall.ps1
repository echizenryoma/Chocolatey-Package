$PackageName = 'cmder'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore
Uninstall-BinFile -Name 'Cmder'

$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "Cmder.lnk"
Remove-Item $LinkPath -Force -ErrorAction Ignore