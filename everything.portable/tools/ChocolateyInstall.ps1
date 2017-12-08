$ErrorActionPreference = 'Stop'

$PackageName = 'everything.portable'
$Url32 = 'https://www.voidtools.com/Everything-1.4.1.877.x86.zip'
$Checksum32 = '522a8c98336fd038f0b7643b17a88317'
$ChecksumType32 = 'md5'
$Url64 = 'https://www.voidtools.com/Everything-1.4.1.877.x64.zip'
$Checksum64 = 'bd63a317ba10623b3fc3406e7d448b63'
$ChecksumType64 = 'md5'
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

Invoke-WebRequest 'https://www.voidtools.com/es.exe' -OutFile $(Join-Path $ToolsPath "es.exe")
