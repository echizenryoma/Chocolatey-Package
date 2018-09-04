$ErrorActionPreference = 'Stop'

$PackageName = 'ghostscript'
$Url32 = 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs924/gs924w32.exe'
$Checksum32 = '0cb21d584b1022c45313d7891ce1a977dc84ec0e67563c957d77c0badc6c960395fd33b521077e6ea2dae01a48f64928fb2e0bc47fff73e7db2e978b5e078139'
$ChecksumType32 = 'sha512'
$Url64 = 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs924/gs924w64.exe'
$Checksum64 = '3e37e1c90f8c059e4c877509e416282b4d7e819d071eae0b982aeb77ac5c22a58f2be21ca9fabe5cd481e6c77156b62f09b89b7456e66dc02bf9f1037efd2da5'
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
