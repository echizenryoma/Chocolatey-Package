$ErrorActionPreference = 'Stop'

$PackageName = 'fastcopy.portable'
$Url32 = 'https://ipmsg.org/archive/FastCopy331.zip'
$Url64 = 'https://ipmsg.org/archive/FastCopy331_x64.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
Get-ChildItem $ToolsPath -File -Include "setup.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type File -Force | Out-Null }
