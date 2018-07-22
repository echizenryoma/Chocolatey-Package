$ErrorActionPreference = 'Stop'

$PackageName = 'fastcopy'
$Url32 = 'https://fastcopy.jp/archive/FastCopy352_installer.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

Get-ChildItem -Directory $ToolsPath | Remove-Item -Recurse -Force -ErrorAction Ignore

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url32
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

$InstallerPath = Get-ChildItem -Path $ToolsPath -Filter *.exe -File
$SilentArgs = "/DIR=`"${ToolsPath}`" /EXTRACT"

$Url32 = $InstallerPath
$PackageArgs = @{
    PackageName  = $PackageName
    Url          = $Url32
    Url64        = $Url32
    SilentArgs   = $SilentArgs
}
Install-ChocolateyPackage @PackageArgs
Get-ChildItem $ToolsPath -File -Include "setup.exe" -Recurse | ForEach-Object { $null = New-Item "$($_.FullName).ignore" -Type File -Force }
