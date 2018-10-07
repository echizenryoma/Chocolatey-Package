$PackageName = 'uget'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore
Uninstall-BinFile -Name $PackageName

$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "uGet.lnk"
Remove-Item $LinkPath -Force -ErrorAction Ignore
