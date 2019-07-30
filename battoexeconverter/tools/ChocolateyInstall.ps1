$ErrorActionPreference = 'Stop'

$PackageName = 'battoexeconverter'
$Url = 'https://zn.amorgan.xyz/17SWVnHoujG92yYGSZvCzPgZEpGVfRF8wi/b2e/downloads/Bat_To_Exe_Converter.zip'
$Checksum = '046744906a71e727676f8b6ffb21bb22'
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

Get-ChildItem $ToolsPath -File -Filter "*.exe" -Include "*Setup*", "*Installer*" -Recurse | ForEach-Object { $null = New-Item "$($_.FullName).ignore" -Type File -Force }
