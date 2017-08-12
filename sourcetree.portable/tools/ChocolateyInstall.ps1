$ErrorActionPreference = 'Stop'

$PackageName = 'sourcetree.portable'
$Url = 'https://www.sourcetreeapp.com/update/windows/ga/SourceTree-2.1.10-full.nupkg'
$Checksum = 'a42e3ac17dd4dcc597b17aec39a242036cdf8d4c'
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

Get-Item $(Join-Path $ToolsPath "*") -Exclude "*.ps1", "lib" | Remove-Item -Force -Recurse
$lib = Join-Path $ToolsPath "lib"
$tmp = Join-Path $ToolsPath "tmp"
if (Test-Path $tmp) {
    Remove-Item -Path $tmp -Force -Recurse
}
Rename-Item -Path $lib -NewName $tmp

Move-Item -Path $(Join-Path $(Get-Item $(Join-Path $tmp "net*")) "*") -Destination $ToolsPath -Force
if (Test-Path $tmp) {
    Remove-Item -Path $tmp -Force -Recurse
}

Get-ChildItem $ToolsPath -Include "*.exe" -Exclude "SourceTree.exe" -File -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
