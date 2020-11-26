$ErrorActionPreference = 'Stop'

$PackageName = 'everything'
$Url32 = 'https://www.voidtools.com/Everything-1.4.1.999.x86.zip'
$Checksum32 = '78f26218424b494140df1fe5be735b20219c099ce7d2807024d9017bd09dc663'
$ChecksumType32 = 'sha256'
$Url64 = 'https://www.voidtools.com/Everything-1.4.1.999.x64.zip'
$Checksum64 = '1183bae477da38e712a85815041055f04275de48f9b049885a6384d3f6fa0963'
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
