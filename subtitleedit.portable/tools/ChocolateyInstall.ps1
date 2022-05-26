$ErrorActionPreference = 'Stop'

$PackageName = 'SubtitleEdit'
$Url = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.6.6/SE366.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

Get-ChildItem $ToolsPath -Include "*.exe" -Exclude "${PackageName}.exe" -Recurse | ForEach-Object { $null = New-Item "$($_.FullName).ignore" -Type file -Force }
