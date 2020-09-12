$ErrorActionPreference = 'Stop'

$PackageName = 'qv2ray'
$Url32 = 'https://github.com/v2fly/v2ray-core/releases/download/v4.28.1/v2ray-windows-32.zip'
$Url64 = 'https://github.com/v2fly/v2ray-core/releases/download/v4.28.1/v2ray-windows-64.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$Qv2rayPath = Join-Path $(Get-ToolsLocation) $PackageName
$Qv2rayConfigPath = Join-Path $Qv2rayPath 'config'
$InstallationPath = Join-Path $Qv2rayConfigPath 'vcore'

. $(Join-Path $ToolsPath "StopProcess.ps1")

New-Item -ItemType Directory -Path $InstallationPath -Force -ErrorAction Ignore

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

$BinFile = (Get-ChildItem $Qv2rayPath -File | Where-Object Name -Match "qv2ray.exe" | Select-Object -First 1).FullName
Start-Process -FilePath $BinFile
