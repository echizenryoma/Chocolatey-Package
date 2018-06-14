$ErrorActionPreference = 'Stop'

$PackageName = 'nodejs'
$Url32 = 'https://npm.taobao.org/mirrors/node/v8.11.3/node-v8.11.3-win-x86.7z'
$Checksum32 = 'df3649ce8fed94c474491d378f1385b949a6208d2f6a6b4097e081ab55501c4e'
$ChecksumType32 = 'sha256'
$Url64 = 'https://npm.taobao.org/mirrors/node/v8.11.3/node-v8.11.3-win-x64.7z'
$Checksum64 = '87ea95cef11a0c840556a164a664917ddaebde76e2dac6607c519d56ea68d5f8'
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
