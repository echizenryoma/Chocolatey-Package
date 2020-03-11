$ErrorActionPreference = 'Stop'

$PackageName = 'subtitleedit'
$Url = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.5.14/SE3514.zip'
$Checksum = '0ab6dd371edb86e9a066067e0006bf91b18c5dcbfcaafef83aa8f1e274d08099'
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
