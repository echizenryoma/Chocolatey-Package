$ErrorActionPreference = 'Stop'

$PackageName = 'ghostscript'
$Url32 = 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs926/gs926w32.exe'
$Checksum32 = '6c7dc9ce438d4fb16dcdc01fc99e7032620461bebc3b323426f9a68f939a260ed1a5af4c3be441c66e5c2c4545bd6b044fca35e29b74e905ad5dd0153e792630'
$ChecksumType32 = 'sha512'
$Url64 = 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs926/gs926w64.exe'
$Checksum64 = '04706ac103e824814ce18d7017c0c27b02883761df64b30fc5f3f978eed6c0f96e3de4a80512013418e0a0e94cf1899c070b49f4211113ce4718b4a51fbf9395'
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
