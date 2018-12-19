$ErrorActionPreference = 'Stop'

$PackageName = 'everything'
$Url32 = 'https://www.voidtools.com/Everything-1.4.1.922.x86.zip'
$Checksum32 = '30aa02494cf3d5131ee31d2adfde1f5b77b0b9042c7c528eca3c78fa8c806b52'
$ChecksumType32 = 'sha256'
$Url64 = 'https://www.voidtools.com/Everything-1.4.1.922.x64.zip'
$Checksum64 = '3cb34153b2d9354944e4a4b01d02765f182ce931f5657660a85945962d12117a'
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
