$ErrorActionPreference = 'Stop'

$PackageName = 'macast'
$Url = 'https://github.com/xfangfang/Macast/releases/download/v0.64/Macast-Windows-v0.64.exe'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

. $(Join-Path $ToolsPath "StopProcess.ps1")

$BinFile = Join-Path $ToolsPath "${PackageName}.exe"

$PackageArgs = @{
    PackageName  = $PackageName
    Url          = $Url
    FileFullPath = $BinFile
}
Get-ChocolateyWebFile @PackageArgs

Write-Output "$PackageName has been installed in $BinFile"

Start-Process -FilePath $BinFile
