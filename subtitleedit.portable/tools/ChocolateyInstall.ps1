$ErrorActionPreference = 'Stop'

$PackageName = 'subtitleedit'
$Url = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.5.11/SE3511.zip'
$Checksum = 'F85EF3DDAD48B9FF1E30A128D61D6280C3546FB557C28C31D31BAA3544C66F70'
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
