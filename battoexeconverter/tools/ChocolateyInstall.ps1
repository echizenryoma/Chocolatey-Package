$ErrorActionPreference = 'Stop'

$PackageName = 'battoexeconverter'
$Url = 'http://www.f2ko.de/downloads/Bat_To_Exe_Converter.zip'
$Checksum = 'b7951aba3e2b005a87859b40c0f7153a'
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
