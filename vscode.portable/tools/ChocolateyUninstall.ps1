$InstallationPath = Join-Path $(Get-ToolsLocation) 'vscode'
Remove-Item $InstallationPath -Recurse -Force | Out-Null
Uninstall-BinFile -Name 'Code'
Remove-Item "$Env:SystemDrive\Users\Public\Desktop\Visual Studio Code.lnk" -Force -ErrorAction Ignore | Out-Null