$ErrorActionPreference = 'Stop'

$PackageName = 'ghostscript'
$Url32 = 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs926/gs926aw32.exe'
$Checksum32 = '5e3f9e8303e1b65c9c6b67dbd3c5a999c7b7eeafe499638d3bbe718ccb1a1b26928dd441d65431b423f385b1a70d698e5027f7ee701c963eb410d3f79fde5a40'
$ChecksumType32 = 'sha512'
$Url64 = 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs926/gs926aw64.exe'
$Checksum64 = '4c961b852bd207e9a1cae00355c5e582ad047dec54912ae5e7d326c4eacc0c8300bf49164d7ba5817f9ab5a7b9cb5d60f235b162dd30c0d6e8706566f7e0a605'
$ChecksumType64 = 'sha512'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $Url32
    Checksum       = $Checksum32
    ChecksumType   = $ChecksumType32
    Url64          = $Url64
    Checksum64     = $Checksum64
    ChecksumType64 = $ChecksumType64
    UnzipLocation  = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
Remove-Item -Path $(Join-Path $ToolsPath "uninstgs.exe.nsis") -Force -ErrorAction Ignore
Remove-Item -Path $(Join-Path $ToolsPath '$PLUGINSDIR') -Recurse -Force -ErrorAction Ignore
