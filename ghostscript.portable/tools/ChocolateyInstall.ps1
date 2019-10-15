$ErrorActionPreference = 'Stop'

$PackageName = 'ghostscript'
$Url32 = 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs950/gs950w32.exe'
$Checksum32 = 'd7d47a2b333d5376f649f21817c40bdb456ff946546817ee1d5dd75a7f4364b57f00f5d90cc7d847eed83fe5f76fcd28753b4993cbc17e21d6847a7daccbca8a'
$ChecksumType32 = 'sha512'
$Url64 = 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs950/gs950w64.exe'
$Checksum64 = '5272205d7a456f869e5e303fabc2509abc2c87bc9b776eafbc0abb5ca668d6a1eb6464330d7c95d43997189377584351d301ce2f72216240a1ff83023f83f5aa'
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
