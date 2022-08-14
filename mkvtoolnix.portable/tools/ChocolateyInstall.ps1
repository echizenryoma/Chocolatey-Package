﻿$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/70.0.0/mkvtoolnix-32-bit-70.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/70.0.0/mkvtoolnix-64-bit-70.0.0.7z'
$Checksum32 = '8da162596b41c79aba0ddfde40ecb39697848947'
$ChecksumType32 = 'sha1'
$Checksum64 = '29d7e8c7d54df808eeda70e0ebb23e813fcf9de6'
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
