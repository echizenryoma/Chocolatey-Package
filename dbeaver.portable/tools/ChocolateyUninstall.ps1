$PackageName = 'dbeaver'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore
Uninstall-BinFile -Name "${PackageName}"
Uninstall-BinFile -Name "${PackageName}-cli"

$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "DBeaver Community Edition.lnk"
Remove-Item $LinkPath -Force -ErrorAction Ignore