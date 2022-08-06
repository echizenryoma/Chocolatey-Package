$ErrorActionPreference = 'Stop'

$PackageName = 'SMPlayer'
$Url32 = 'https://sourceforge.net/projects/smplayer/files/SMPlayer/21.10.0/smplayer-portable-21.10.0.0-win32-qt5.6.7z/download'
$Url64 = 'https://sourceforge.net/projects/smplayer/files/SMPlayer/21.10.0/smplayer-portable-21.10.0.0-x64.7z/download'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Join-Path $InstallationPath 'tmp'

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$UnzipPath = (Get-ChildItem $UnzipLocation -Directory | Where-Object Name -Match "${PackageName}" | Select-Object -First 1).FullName
Copy-Item -Path $(Join-Path $UnzipPath "*") -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore

$BinFile = Join-Path $InstallationPath "${PackageName}.exe"
Install-BinFile -Name ${PackageName} -Path $BinFile
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "${PackageName}.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinFile -WorkingDirectory $InstallationPath
