$ErrorActionPreference = 'Stop'

$PackageName = 'ghostscript'
$Url32 = 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs925/gs925w32.exe'
$Checksum32 = '7726973b32c982abcb7aad1512fa35b2e14a811bd4cba56a4a49b63dbf695e28492ddcfde88a110cbc309c05d454e63d3721514a33e15ab5d46275007a04d1c1'
$ChecksumType32 = 'sha512'
$Url64 = 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs925/gs925w64.exe'
$Checksum64 = '8f8cc87459c4bfee34a078862fad8a674e84385c223deeac07142085f8d3669ae3b101466d254b44b31ed2d9b3d7c0fdacbeb4fa0ba4e0cabdac4d10de02f065'
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
