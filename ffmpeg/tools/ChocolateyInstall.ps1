$ErrorActionPreference = 'Stop'

$PackageName = 'ffmpeg'
$Url = 'https://github.com/GyanD/codexffmpeg/releases/download/4.4.1/ffmpeg-4.4.1-full_build-shared.7z'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

Get-ChildItem -Directory $ToolsPath | Remove-Item -Recurse -Force -ErrorAction Ignore

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

$UnzipLocation = (Get-ChildItem -Directory -Path $ToolsPath | Select-Object -Last 1).FullName
Rename-Item -Path $UnzipLocation -NewName $PackageName -Force
