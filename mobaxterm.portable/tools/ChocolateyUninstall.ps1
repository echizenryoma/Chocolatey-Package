$PackageName = 'mobaxterm'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore
Remove-Item "$Env:SystemDrive\Users\Public\Desktop\MobaXterm.lnk" -Force -ErrorAction Ignore
