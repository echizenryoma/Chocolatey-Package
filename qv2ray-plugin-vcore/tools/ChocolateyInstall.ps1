$ErrorActionPreference = 'Stop'

$PackageName = 'qv2ray'
$Url32 = 'https://github.com/v2fly/v2ray-core/releases/download/v4.39.2/v2ray-windows-32.zip'
$Url64 = 'https://github.com/v2fly/v2ray-core/releases/download/v4.39.2/v2ray-windows-64.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

. $(Join-Path $ToolsPath "StopProcess.ps1")

$Qv2rayPath = Join-Path $(Get-ToolsLocation) $PackageName
$Qv2rayConfigPath = Join-Path $Qv2rayPath 'config'
$UnzipLocation = Join-Path $Qv2rayConfigPath 'vcore'

Write-Output $UnzipLocation

New-Item -ItemType Directory -Path $UnzipLocation -Force -ErrorAction Ignore

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$BinFile = (Get-ChildItem $Qv2rayPath -File | Where-Object Name -Match "qv2ray.exe" | Select-Object -First 1).FullName
Start-Process -FilePath $BinFile
