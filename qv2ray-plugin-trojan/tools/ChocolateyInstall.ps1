$ErrorActionPreference = 'Stop'

$PackageName = 'qv2ray'
$Url32 = 'https://github.com/Qv2ray/QvPlugin-Trojan/releases/download/v2.0.0/QvTrojanPlugin.v2.0.0.Windows-x86.dll'
$Url64 = 'https://github.com/Qv2ray/QvPlugin-Trojan/releases/download/v2.0.0/QvTrojanPlugin.v2.0.0.Windows-x64.dll'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

. $(Join-Path $ToolsPath "StopProcess.ps1")

$Qv2rayPath = Join-Path $(Get-ToolsLocation) $PackageName
$Qv2rayConfigPath = Join-Path $Qv2rayPath 'config'
$Qv2rayPluginPath = Join-Path $Qv2rayConfigPath 'plugin'
$InstallationPath = Join-Path $Qv2rayPluginPath $([IO.Path]::GetFileName($Url32))

if ((Get-OSArchitectureWidth 64) -and $Env:ChocolateyForceX86 -ne 'true') {
    $InstallationPath = Join-Path $Qv2rayPluginPath $([IO.Path]::GetFileName($Url64))
}

Write-Output $InstallationPath

New-Item -ItemType Directory -Path $Qv2rayPluginPath -Force -ErrorAction Ignore

$PackageArgs = @{
    PackageName  = $PackageName
    Url          = $Url32
    Url64        = $Url64
    FileFullPath = $InstallationPath
}
Get-ChocolateyWebFile @PackageArgs

$BinFile = (Get-ChildItem $Qv2rayPath -File | Where-Object Name -Match "qv2ray.exe" | Select-Object -First 1).FullName
Start-Process -FilePath $BinFile
