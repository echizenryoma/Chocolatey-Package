$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix.portable'
$Url32 = 'https://mkvtoolnix.download/windows/releases/14.0.0/mkvtoolnix-32bit-14.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/14.0.0/mkvtoolnix-64bit-14.0.0.7z'
$Checksum32 = '04f6c4cca88cf18429dcba358d112490af6ae735'
$ChecksumType32 = 'sha1'
$Checksum64 = '337556f2fc7be01f942b4c21c4fb858d9c333142'
$ChecksumType64 = 'sha1'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName    = $PackageName
    url            = $Url32
    Checksum       = $Checksum32
    ChecksumType   = $ChecksumType32
    url64          = $Url64
    Checksum64     = $Checksum64
    ChecksumType64 = $ChecksumType64
    UnzipLocation  = $ToolsPath
}

Install-ChocolateyZipPackage @PackageArgs
