$ErrorActionPreference = 'Stop';

$PackageName = 'nodejs'
$Url32 = 'https://npm.taobao.org/mirrors/node/v6.11.5/node-v6.11.5-win-x86.7z'
$Checksum32 = '405db7d106865f074f9cb99790ed0f3946678cdd09ce8b193f6c691be56af9be'
$ChecksumType32 = 'sha256'
$Url64 = 'https://npm.taobao.org/mirrors/node/v6.11.5/node-v6.11.5-win-x64.7z'
$Checksum64 = '5ac17f02726b23fe88ed1653d6082f59da42fe17c92570d021c0d8cf594a58d9'
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
