$ErrorActionPreference = 'Stop'

$PackageName = 'smplayer'
$Url32 = 'https://sourceforge.net/projects/smplayer/files/SMPlayer/19.1.0/smplayer-portable-19.1.0.0.7z/download'
$Url64 = 'https://sourceforge.net/projects/smplayer/files/SMPlayer/19.1.0/smplayer-portable-19.1.0.0-x64.7z/download'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

Get-ChildItem -Directory $ToolsPath | Remove-Item -Recurse -Force -ErrorAction Ignore

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

$InstallationPath = (Get-ChildItem $ToolsPath -Directory | Where-Object Name -Match "${PackageName}" | Select-Object -First 1).FullName
$BinFileName = Join-Path $InstallationPath "${PackageName}.exe"
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "${PackageName}.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinFileName -WorkingDirectory $InstallationPath
