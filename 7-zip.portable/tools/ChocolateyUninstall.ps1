$PackageName = '7-zip'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore
Uninstall-BinFile -Name '7z'

$SystemStartMenuPath = [IO.Path]::Combine($([Environment]::GetFolderPath('CommonApplicationData')), "Microsoft", "Windows", "Start Menu", "Programs")
$LinkPath = Join-Path $SystemStartMenuPath "7-Zip File Manager.lnk"
Remove-Item -Path $LinkPath -Force -ErrorAction Ignore
