$ErrorActionPreference = 'Stop'

$PackageName = 'fastcopy'
$Url32 = 'https://fastcopy.jp/archive/FastCopy381_installer.exe'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$SilentArgs = "/DIR=`"${ToolsPath}`" /EXTRACT"

Get-ChildItem -Directory $ToolsPath | Remove-Item -Recurse -Force -ErrorAction Ignore

$PackageArgs = @{
    PackageName = $PackageName
    Url         = $Url32
    SilentArgs  = $SilentArgs
}
Install-ChocolateyPackage @PackageArgs

Get-ChildItem $ToolsPath -File -Include "setup.exe" -Recurse | ForEach-Object { $null = New-Item "$($_.FullName).ignore" -Type File -Force }
