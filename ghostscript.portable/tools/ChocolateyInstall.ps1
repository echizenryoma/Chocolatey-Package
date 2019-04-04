$ErrorActionPreference = 'Stop'

$PackageName = 'ghostscript'
$Url32 = 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs927/gs927w32.exe'
$Checksum32 = 'ef18548c62a5107f951d839d7c83ea5e03b35b2b85fd2c820b95687fb28e9ebfc799c2efe87d6db16879a8d9d995fe56f0b6a1248df0d6ee41d5851edfce9f83'
$ChecksumType32 = 'sha512'
$Url64 = 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs927/gs927w64.exe'
$Checksum64 = '49fc973bfae12f366a837bcc39d93e3d8e3c88359f7d45279df899f0b2941c264efc47815966867d332b32e87ca8d88697edf7792b162645ed7a549cecc373b2'
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
