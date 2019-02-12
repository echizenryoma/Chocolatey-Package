$ErrorActionPreference = 'Stop'

$PackageName = 'subtitleedit'
$Url = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.5.9/SE359.zip'
$Checksum = '9eeca6bba1084f84a9cefcda4109ff7865f5699d7f501a1c6beb5df84bd0df05'
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
