$PackageName = 'notepadplusplus'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore
Uninstall-BinFile -Name 'notepad++'

$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "Nodepad++.lnk"
Remove-Item $LinkPath -Force -ErrorAction Ignore