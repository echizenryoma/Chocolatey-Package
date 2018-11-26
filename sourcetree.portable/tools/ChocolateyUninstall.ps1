$PackageName = 'sourcetree'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore
Uninstall-BinFile -Name $PackageName

$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "Source Tree.lnk"
Remove-Item $LinkPath -Force -ErrorAction Ignore