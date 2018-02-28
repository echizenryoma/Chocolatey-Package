$ErrorActionPreference = 'Stop'

$PackageName = 'redis-desktop-manager'
$Url = 'https://github.com/uglide/RedisDesktopManager/releases/download/0.9.0-3/redis-desktop-manager-0.9.0.738.exe'
$ToolsPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

Remove-Item -Path $(Join-Path $ToolsPath '$PLUGINSDIR') -Force -Recurse -ErrorAction Ignore
Remove-Item -Path $(Join-Path $ToolsPath 'Uninstall.exe') -Force -ErrorAction Ignore

Get-ChildItem $ToolsPath -File -Filter "*.exe" -Exclude "rdm.exe" -Recurse | ForEach-Object { $null = New-Item "$($_.FullName).ignore" -Type File -Force}
