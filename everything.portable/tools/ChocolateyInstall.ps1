$ErrorActionPreference = 'Stop'

$PackageName = 'everything'
$Url32 = 'https://www.voidtools.com/Everything-1.4.1.1003.x86.zip'
$Checksum32 = 'a56c7b7960b1e6520ecf81ef2629cb12c6d0fffc5d3e9d114995e4a67ab80ec9'
$ChecksumType32 = 'sha256'
$Url64 = 'https://www.voidtools.com/Everything-1.4.1.1003.x64.zip'
$Checksum64 = '4a067fa79d1ed1d49947c76984e804cc9ad9f0a9325987af4c5db8e4b82092e0'
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
