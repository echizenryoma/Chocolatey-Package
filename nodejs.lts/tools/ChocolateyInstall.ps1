$ErrorActionPreference = 'Stop';

$PackageName = 'nodejs'
$Url32 = 'https://npm.taobao.org/mirrors/node/v8.9.0/node-v8.9.0-win-x86.7z'
$Checksum32 = 'b903cdfa53421582685e84766de6beaa5d1e82caf6e197e4809a96c8bef31c4d'
$ChecksumType32 = 'sha256'
$Url64 = 'https://npm.taobao.org/mirrors/node/v8.9.0/node-v8.9.0-win-x64.7z'
$Checksum64 = '46ce25a96592b3eec86093f44c4031a701c8678a4d62f6ea74378d1bfec26975'
$ChecksumType64 = 'sha256'
$ToolsPath = $(Get-ToolsLocation)

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $Url32
    Checksum       = $Checksum32
    ChecksumType   = $ChecksumType32
    Url64          = $Url64
    Checksum64     = $Checksum64
    ChecksumType64 = $ChecksumType64
    UnzipLocation  = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

$UnzipPath = (Get-ChildItem $ToolsPath -Directory | Where-Object Name -Like "node-v*-win-x*" | Select-Object -First 1).FullName
$NodejsPath = Join-Path $ToolsPath "nodejs"
Copy-Item -Path $(Join-Path $UnzipPath '*') -Destination $NodejsPath -Force -Recurse
Install-ChocolateyPath -PathToInstall $NodejsPath -PathType 'Machine'
Remove-Item -Path $UnzipPath -Force -Recurse
