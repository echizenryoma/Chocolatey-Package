$PackageName = 'vscode'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore
Uninstall-BinFile -Name 'Code'

$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "Visual Studio Code.lnk"
Remove-Item -Path $LinkPath -Force -ErrorAction Ignore