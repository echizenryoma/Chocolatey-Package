$ErrorActionPreference = 'Stop'

$PackageName = 'subtitleedit.portable'
$Url = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.5.4/SE354.zip'
$Checksum = 'addb7c096d88318b81c6c12597fca58a41394096'
$ChecksumType = 'sha1'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    Checksum      = $Checksum
    ChecksumType  = $ChecksumType
    UnzipLocation = $ToolsPath
}

Install-ChocolateyZipPackage @PackageArgs
Get-ChildItem $ToolsPath -Include "*.exe" -Exclude "SubtitleEdit.exe" -Recurse  | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
