$PackageName = 'mobaxterm'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore

$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "MobaXterm.lnk"
Remove-Item $LinkPath -Force -ErrorAction Ignore