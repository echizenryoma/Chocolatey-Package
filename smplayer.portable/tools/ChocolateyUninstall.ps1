$PackageName = 'smplayer'

$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "${PackageName}.lnk"
Remove-Item $LinkPath -Force -ErrorAction Ignore
Uninstall-BinFile -Name ${PackageName}
