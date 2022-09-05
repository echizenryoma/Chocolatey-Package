$ErrorActionPreference = 'Stop'

$PackageName = 'x64dbg'
$Url32 = 'https://sourceforge.net/projects/x64dbg/files/snapshots/snapshot_2022-09-04_22-34.zip'
$ToolsPath = Split-Path $MyInvocation.MyCommand.Definition

. $(Join-Path $ToolsPath "StopProcess.ps1")

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

Get-ChildItem $ToolsPath -File -Filter "*.exe" -Exclude "x*dbg.exe" -Recurse | ForEach-Object {
    $null = New-Item "$($_.FullName).ignore" -Type File -Force
}
