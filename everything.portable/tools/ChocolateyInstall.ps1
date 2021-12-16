$ErrorActionPreference = 'Stop'

$PackageName = 'everything'
$Url32 = 'https://www.voidtools.com/Everything-1.4.1.1014.x86.zip'
$Checksum32 = '6e3fe70ac2f2dd78c08e810e74a7cc17983bc871abaf319c7a5acb296bcb8a1c'
$ChecksumType32 = 'sha256'
$Url64 = 'https://www.voidtools.com/Everything-1.4.1.1014.x64.zip'
$Checksum64 = 'cca3236c113ec2312555f7d57137d2a6a7425e5bba10d58b682a4b0d891dd4ea'
$ChecksumType64 = 'sha256'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$UrlExtra = 'https://www.voidtools.com/es.exe'

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

$PackageArgs = @{
    PackageName  = $PackageName
    Url          = $UrlExtra
    FileFullPath = Join-Path $ToolsPath $([IO.Path]::GetFileName($UrlExtra))
}
Get-ChocolateyWebFile @PackageArgs
