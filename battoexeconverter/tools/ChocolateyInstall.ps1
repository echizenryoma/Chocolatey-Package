$ErrorActionPreference = 'Stop'

$PackageName = 'battoexeconverter'
$Url = 'http://www.f2ko.de/downloads/Bat_To_Exe_Converter.zip'
$Checksum = '07658c8451d8043a922305c66824ff62'
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

Get-ChildItem $ToolsPath -File -Filter "*.exe" -Include "*Setup*", "*Installer*" -Recurse | ForEach-Object { $null = New-Item "$($_.FullName).ignore" -Type File -Force}
