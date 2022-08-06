$ErrorActionPreference = 'Stop'

$PackageName = 'SMPlayer'
$Url64 = 'https://sourceforge.net/projects/smplayer/files/SMPlayer/22.7.0/smplayer-22.7.0-x64.exe/download'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url64         = $Url64
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

$BinFile = Join-Path $InstallationPath "${PackageName}.exe"
Install-BinFile -Name ${PackageName} -Path $BinFile
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "${PackageName}.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinFile -WorkingDirectory $InstallationPath
