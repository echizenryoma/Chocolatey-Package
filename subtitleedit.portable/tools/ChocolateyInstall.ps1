$ErrorActionPreference = 'Stop'

$PackageName = 'subtitleedit'
$Url = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.5.10/SE3510.zip'
$Checksum = '4b4eee70ce2256a327e57dcb198dd4a627d33fb1fa4a23f4b3628019d82105fe'
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
