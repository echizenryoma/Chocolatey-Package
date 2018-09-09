$ErrorActionPreference = 'Stop'

$PackageName = 'subtitleedit'
$Url = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.5.7/SE357.zip'
$Checksum = 'dc768b9e361f08f783c8bd370338a676eab43f3bf2918cb407af9e20881e48f2'
$ChecksumType = 'sha256'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    Checksum      = $Checksum
    ChecksumType  = $ChecksumType
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

Get-ChildItem $ToolsPath -Include "*.exe" -Exclude "SubtitleEdit.exe" -Recurse | ForEach-Object { $null = New-Item "$($_.FullName).ignore" -Type file -Force }
