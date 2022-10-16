$ErrorActionPreference = 'Stop'

$PackageName = 'nmap'
$Url32 = 'https://nmap.org/dist/nmap-7.93-setup.exe'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InstallationPath = (Get-Item -Path $ToolsPath).FullName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

Remove-Item -Path $(Join-Path $InstallationPath '$PLUGINSDIR') -Recurse -Force
Remove-Item -Path $(Join-Path $InstallationPath 'Uninstall.exe') -Force

Get-ChildItem $ToolsPath -File -Exclude @("ncat.exe", "ndiff.exe", "nmap.exe", "nping.exe", "zenmap.exe") -Recurse | ForEach-Object { $null = New-Item "$($_.FullName).ignore" -Type File -Force }
