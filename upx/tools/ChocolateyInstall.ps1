$ErrorActionPreference = 'Stop'

$PackageName = 'upx'
$Url32 = 'https://github.com/upx/upx/releases/download/v3.96/upx-3.96-win32.zip'
$Url64 = 'https://github.com/upx/upx/releases/download/v3.96/upx-3.96-win64.zip'
$ToolsPath = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)

Get-ChildItem -Directory $ToolsPath | Remove-Item -Recurse -Force -ErrorAction Ignore

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    Checksum      = $Checksum
    ChecksumType  = $ChecksumType
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
