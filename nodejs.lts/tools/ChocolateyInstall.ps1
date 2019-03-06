$ErrorActionPreference = 'Stop'

$PackageName = 'nodejs'
$Url32 = 'https://npm.taobao.org/mirrors/node/v10.15.3/node-v10.15.3-win-x86.7z'
$Checksum32 = '597a372964252daaba4cb8dcac57305f79cffeeca579625f0cd6ab85d29ccdda'
$ChecksumType32 = 'sha256'
$Url64 = 'https://npm.taobao.org/mirrors/node/v10.15.3/node-v10.15.3-win-x64.7z'
$Checksum64 = '9df98cac063229aca443c040fd342a96667891bb8eda821d10aa4d49347d7add'
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
Copy-Item -Path $(Join-Path $UnzipPath "*") -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipPath -Recurse -Force -ErrorAction Ignore

Install-ChocolateyPath -PathToInstall $InstallationPath -PathType 'Machine'
