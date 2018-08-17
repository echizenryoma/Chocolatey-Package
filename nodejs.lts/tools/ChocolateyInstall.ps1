$ErrorActionPreference = 'Stop'

$PackageName = 'nodejs'
$Url32 = 'https://npm.taobao.org/mirrors/node/v8.11.4/node-v8.11.4-win-x86.7z'
$Checksum32 = '6766a873857346553d854b0f34d5f00c49e08c75710c1da8c4fee5d1fe3cc9fe'
$ChecksumType32 = 'sha256'
$Url64 = 'https://npm.taobao.org/mirrors/node/v8.11.4/node-v8.11.4-win-x64.7z'
$Checksum64 = '0b5bc0b0bb992abec341dd70aa71b89cfa3c2fd9590a555c83cb3bb3bbcd5ebc'
$ChecksumType64 = 'sha256'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Get-ToolsLocation

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $Url32
    Checksum       = $Checksum32
    ChecksumType   = $ChecksumType32
    Url64          = $Url64
    Checksum64     = $Checksum64
    ChecksumType64 = $ChecksumType64
    UnzipLocation  = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$null = New-Item -ItemType Directory -Force -Path $InstallationPath -ErrorAction Ignore
$UnzipPath = (Get-ChildItem $UnzipLocation -Directory | Where-Object Name -Like "node-v*-win-x*" | Select-Object -First 1).FullName
Start-ChocolateyProcessAsAdmin -ExeToRun 'xcopy' -Statements "`"$UnzipPath`" `"$InstallationPath`" /s /y /q"
Start-ChocolateyProcessAsAdmin -ExeToRun 'cmd' -Statements "/c rmdir `"$UnzipPath`" /s /q"

Install-ChocolateyPath -PathToInstall $InstallationPath -PathType 'Machine'
