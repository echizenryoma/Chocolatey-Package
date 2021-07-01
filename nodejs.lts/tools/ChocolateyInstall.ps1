$ErrorActionPreference = 'Stop'

$PackageName = 'nodejs'
$Url32 = 'https://nodejs.org/dist/v14.17.2/node-v14.17.2-win-x86.7z'
$Checksum32 = 'b5b2f6d2523b0c60399111b4c60ee3066d6e7e51fe22ce045c5181d52dd2dd20'
$ChecksumType32 = 'sha256'
$Url64 = 'https://nodejs.org/dist/v14.17.2/node-v14.17.2-win-x64.7z'
$Checksum64 = '6f59257b20861efb506f9b7f5b8587a310c6df6de4d719324ae8f3dcda68bcbc'
$ChecksumType64 = 'sha256'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Join-Path $InstallationPath 'tmp'

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

$UnzipPath = (Get-ChildItem $UnzipLocation -Directory | Where-Object Name -Match "node" | Select-Object -First 1).FullName
Copy-Item -Path $(Join-Path $UnzipPath "*") -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore

Install-ChocolateyPath -PathToInstall $InstallationPath -PathType 'Machine'
