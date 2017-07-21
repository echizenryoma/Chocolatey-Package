$ErrorActionPreference = 'Stop'

$PackageName = 'sourcetree.portable'
$Url =  'https://www.sourcetreeapp.com/update/windows/ga/SourceTree-2.1.7-full.nupkg'
$Checksum = 'b33c7652a287d1d043d08433fe917e40fda01379'
$ChecksumType = 'sha1'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    url           = $Url
    Checksum      = $Checksum
    ChecksumType  = $ChecksumType
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

Get-Item $(Join-Path $ToolsPath "*") -Exclude "*.ps1", "lib" | Remove-Item -Force -Recurse
$lib = Join-Path $ToolsPath "lib"
$files = Join-Path $(Get-Item $(Join-Path $lib "net*")) "*"
Move-Item $files $ToolsPath -Force
if (Test-Path $lib) {
    Remove-Item $lib -Force -Recurse
}

Get-ChildItem $ToolsPath -Include "*.exe" -Exclude "SourceTree.exe" -File -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
