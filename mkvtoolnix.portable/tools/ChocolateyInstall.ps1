﻿$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/39.0.0/mkvtoolnix-32-bit-39.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/39.0.0/mkvtoolnix-64-bit-39.0.0.7z'
$Checksum32 = '422f0df092f715d2342448f50bcc9568be25de1a'
$ChecksumType32 = 'sha1'
$Checksum64 = 'eb079c45f1d4bdb7279a56a8595e2363b90bedb5'
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
