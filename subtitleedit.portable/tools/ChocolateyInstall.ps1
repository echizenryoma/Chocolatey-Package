$ErrorActionPreference = 'Stop'

$PackageName = 'subtitleedit.portable'
$Url = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.5.3/SE353.zip'
$Checksum = '5f4979f887e6d1fedeb2ee67dad18eb42333b1f2'
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
