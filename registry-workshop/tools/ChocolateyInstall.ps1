$ErrorActionPreference = 'Stop'

$PackageName = 'registry-workshop'
$Url = 'http://www.torchsoft.com/download/RegistryWorkshop_chs.exe'
$ToolsPath = Split-Path $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $ToolsPath
}

Install-ChocolateyZipPackage @PackageArgs
Remove-Item -Path $(Join-Path $ToolsPath '$PLUGINSDIR') -Force -Recurse -ErrorAction Ignore
Remove-Item -Path $(Join-Path $ToolsPath 'Uninstall.exe') -Force -ErrorAction Ignore
Get-ChildItem $ToolsPath -Include "keygen.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type File -Force | Out-Null }
