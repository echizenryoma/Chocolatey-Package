$ErrorActionPreference = 'Stop';

$PackageName = 'nodejs'
$Url32 = 'https://npm.taobao.org/mirrors/node/v6.11.4/node-v6.11.4-win-x86.7z'
$Checksum32 = '2e4bbc044561c029c73ad07d8cf2b9455fdcf2892797dcb5757a8f8bca4d4f5e'
$ChecksumType32 = 'sha256'
$Url64 = 'https://npm.taobao.org/mirrors/node/v6.11.4/node-v6.11.4-win-x64.7z'
$Checksum64 = '81d3b153a4dcfe25df925d3f7a589121fce1f1523cf67aa8156115968938eb76'
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

$UnzipPath = (Get-ChildItem $ToolsPath -Directory | Where-Object Name -Like "node-*-win-x*" | Select-Object -First 1).FullName
$NodejsPath = Join-Path $ToolsPath "nodejs"
Move-Item -Path $UnzipPath -Destination $NodejsPath -Force
Install-ChocolateyPath -PathToInstall $NodejsPath -PathType 'Machine'
