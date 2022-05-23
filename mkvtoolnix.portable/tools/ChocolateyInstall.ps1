$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/68.0.0/mkvtoolnix-32-bit-68.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/68.0.0/mkvtoolnix-64-bit-68.0.0.7z'
$Checksum32 = 'bb3ab6f7dd4a8507b588ddd561be1e3a04edcdb1'
$ChecksumType32 = 'sha1'
$Checksum64 = '095248c4983de312c3b63f8f0579ba2aceaf4856'
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
