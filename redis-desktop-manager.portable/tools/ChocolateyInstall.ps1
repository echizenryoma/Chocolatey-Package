$ErrorActionPreference = 'Stop'

$PackageName = 'redis-desktop-manager'
$Url = 'https://github.com/uglide/RedisDesktopManager/releases/download/0.9.0-4/redis-desktop-manager-0.9.0.751.exe'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

Remove-Item -Path $(Join-Path $InstallationPath '$PLUGINSDIR') -Force -Recurse -ErrorAction Ignore
Remove-Item -Path $(Join-Path $InstallationPath 'Uninstall.exe') -Force -ErrorAction Ignore

$BinFileName = Join-Path $InstallationPath "rdm.exe"
Install-BinFile -Name 'rdm' -Path $BinFileName
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "Redis Desktop Manager.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinFileName -WorkingDirectory $InstallationPath
