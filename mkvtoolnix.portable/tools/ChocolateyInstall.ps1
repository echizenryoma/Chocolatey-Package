﻿$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/60.0.0/mkvtoolnix-32-bit-60.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/60.0.0/mkvtoolnix-64-bit-60.0.0.7z'
$Checksum32 = 'cf0d6404e85c2789992326e7ff648af34ff3ae02'
$ChecksumType32 = 'sha1'
$Checksum64 = '0b923d820375ca50fe5e167376b0d7c6f8ecdd77'
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
