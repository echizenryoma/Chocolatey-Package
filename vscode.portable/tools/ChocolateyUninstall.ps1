$PackageName = 'vscode'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore
Uninstall-BinFile -Name 'Code'
Remove-Item "$Env:SystemDrive\Users\Public\Desktop\Visual Studio Code.lnk" -Force -ErrorAction Ignore