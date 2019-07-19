$ErrorActionPreference = 'Stop'

$PackageName = 'ffmpeg'
$Url32 = 'https://ffmpeg.zeranoe.com/builds/win32/shared/ffmpeg-4.1.4-win32-shared.zip'
$Url64 = 'https://ffmpeg.zeranoe.com/builds/win64/shared/ffmpeg-4.1.4-win64-shared.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

Get-ChildItem -Directory $ToolsPath | Remove-Item -Recurse -Force -ErrorAction Ignore

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

$UnzipLocation = (Get-ChildItem -Directory -Path $ToolsPath | Select-Object -Last 1).FullName
Rename-Item -Path $UnzipLocation -NewName $PackageName -Force
