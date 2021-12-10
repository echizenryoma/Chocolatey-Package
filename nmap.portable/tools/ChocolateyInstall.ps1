$ErrorActionPreference = 'Stop'

$PackageName = 'nmap'
$Url32 = 'https://nmap.org/dist/nmap-7.92-win32.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InstallationPath = Join-Path $ToolsPath $PackageName
$UnzipLocation = Join-Path $InstallationPath 'tmp'

Get-ChildItem -Path $ToolsPath -Directory | Remove-Item -Recurse -Force -ErrorAction Ignore

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    UnzipLocation = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$UnzipPath = (Get-ChildItem $UnzipLocation -Directory | Where-Object Name -Match "${PackageName}" | Select-Object -First 1).FullName
Copy-Item -Path $(Join-Path $UnzipPath "*") -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore

Get-ChildItem $ToolsPath -File -Include "VC_redist*" -Recurse | ForEach-Object { $null = New-Item "$($_.FullName).ignore" -Type File -Force }
