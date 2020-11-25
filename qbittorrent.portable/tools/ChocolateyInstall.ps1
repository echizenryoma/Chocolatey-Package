$ErrorActionPreference = 'Stop'

$PackageName = 'qbittorrent'
$Url32 = 'https://sourceforge.net/projects/qbittorrent/files/qbittorrent-win32/qbittorrent-4.3.1/qbittorrent_4.3.1_setup.exe/download'
$Url64 = 'https://sourceforge.net/projects/qbittorrent/files/qbittorrent-win32/qbittorrent-4.3.1/qbittorrent_4.3.1_x64_setup.exe/download'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
Remove-Item -Path $(Join-Path $ToolsPath "uninst.exe") -Force -ErrorAction Ignore
Remove-Item -Path $(Join-Path $ToolsPath '$PLUGINSDIR') -Recurse -Force -ErrorAction Ignore
