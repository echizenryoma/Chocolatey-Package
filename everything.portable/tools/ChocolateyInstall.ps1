$ErrorActionPreference = 'Stop'

$PackageName = 'everything'
$Url32 = 'https://www.voidtools.com/Everything-1.4.1.924.x86.zip'
$Checksum32 = 'cb15f87ba5a47520d0b06f6b177616276cdb9f9dbe3b5669bed8f24efe4edb9b'
$ChecksumType32 = 'sha256'
$Url64 = 'https://www.voidtools.com/Everything-1.4.1.924.x64.zip'
$Checksum64 = '3f4f73443ca52188a120b3277f27bb00e35b7aacc663dc3cfb954e0c2b1d21f5'
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
