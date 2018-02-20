$ErrorActionPreference = 'Stop'

$PackageName = 'ffmpeg'
$Url32 = 'https://ffmpeg.zeranoe.com/builds/win32/shared/ffmpeg-3.4.1-win32-shared.zip'
$Url64 = 'https://ffmpeg.zeranoe.com/builds/win64/shared/ffmpeg-3.4.1-win64-shared.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

Get-ChildItem -Directory $ToolsPath | Remove-Item -Recurse -Force -ErrorAction Ignore

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
