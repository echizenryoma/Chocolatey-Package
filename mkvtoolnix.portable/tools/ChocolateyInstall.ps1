$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/25.0.0/mkvtoolnix-32-bit-25.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/25.0.0/mkvtoolnix-64-bit-25.0.0.7z'
$Checksum32 = 'b6a6af7806b970f857c046b5bce842a268f981cc'
$ChecksumType32 = 'sha1'
$Checksum64 = '263e546efc2248355b71383b93cc4dfe86b8443d'
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
