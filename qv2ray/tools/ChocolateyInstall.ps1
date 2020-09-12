$ErrorActionPreference = 'Stop'

$PackageName = 'qv2ray'
$Url32 = 'https://github.com/Qv2ray/Qv2ray/releases/download/v2.6.3/Qv2ray.v2.6.3.Windows-x86.7z'
$Url64 = 'https://github.com/Qv2ray/Qv2ray/releases/download/v2.6.3/Qv2ray.v2.6.3.Windows-x64.7z'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Join-Path $InstallationPath 'tmp'

. $(Join-Path $ToolsPath "StopProcess.ps1")

New-Item -ItemType Directory -Path $UnzipLocation -Force -ErrorAction Ignore

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$BinFile = (Get-ChildItem $UnzipLocation -File -Recurse | Where-Object Name -Match "qv2ray.exe" | Select-Object -First 1).FullName
$UnzipPath = (Get-Item -Path $BinFile).Directory.FullName
Copy-Item -Path $(Join-Path $UnzipPath "*") -Destination $InstallationPath -Recurse -Force
$BinFile = (Get-ChildItem $InstallationPath -File | Where-Object Name -Match "qv2ray.exe" | Select-Object -First 1).FullName
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore

Write-Output "$PackageName has been installed in $BinFile"

Start-Process -FilePath $BinFile
