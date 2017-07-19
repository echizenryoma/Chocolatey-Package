$ErrorActionPreference = 'Stop'

$PackageName = 'battoexeconverter'
$Url = 'http://www.f2ko.de/downloads/Bat_To_Exe_Converter.zip'
$Checksum = '2d125a6a328ebfcc9ff5e6ddcb172565'
$ChecksumType = 'md5'
$ToolsPath = Split-Path $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    Checksum      = $Checksum
    ChecksumType  = $ChecksumType
    UnzipLocation = $ToolsPath
}

Install-ChocolateyZipPackage @PackageArgs
Get-ChildItem $ToolsPath -File -Include "*Setup*.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type File -Force | Out-Null }
