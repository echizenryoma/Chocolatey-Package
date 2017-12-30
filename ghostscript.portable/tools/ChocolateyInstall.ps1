$ErrorActionPreference = 'Stop'

$PackageName = 'ghostscript.portable'
$Url32 = 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs922/gs922w32.exe'
$Checksum32 = 'c01b36529c618f9218c39c84bf7168fc2e466a78406f273609f736a5f0cd965a'
$ChecksumType32 = 'SHA256'
$Url64 = 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs922/gs922w64.exe'
$Checksum64 = '796cd308d3134d021356c0db1831c089db73d03aac07d28cbe77958163c79d57'
$ChecksumType64 = 'SHA256'
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
