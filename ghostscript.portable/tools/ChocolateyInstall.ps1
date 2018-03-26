$ErrorActionPreference = 'Stop'

$PackageName = 'ghostscript'
$Url32 = 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs923/gs923w32.exe'
$Checksum32 = '6cf1d13e72c1fcd1fbdc5114d7dfba996580301047ddcc2edc9559cf7602b7a0878a856795c728df864de86426fdc051bc7992d6666d2a991f676c8b523a1c17'
$ChecksumType32 = 'sha512'
$Url64 = 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs923/gs923w64.exe'
$Checksum64 = '2af6e6115a4719de3ef2cc8bd3e68fd51b4297879bcf2c09326506ff1097c4f1bc781c9d21f95d17abf13d034bb22b356c46de4b91ac4c94074ff8f52c010360'
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
