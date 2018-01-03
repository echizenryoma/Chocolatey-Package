$ErrorActionPreference = 'Stop'

$PackageName = 'battoexeconverter'
$Url = 'http://www.f2ko.de/downloads/Bat_To_Exe_Converter.zip'
$Checksum = '05a3edccbf3d123cc7426eb855dc4f01'
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
Get-ChildItem $ToolsPath -File -Include "*Setup*.exe" -Recurse | ForEach-Object { $null = New-Item "$($_.FullName).ignore" -Type File -Force}
