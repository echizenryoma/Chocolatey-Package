$ErrorActionPreference = 'Stop';

$PackageName = 'nodejs'
$Url32 = 'https://npm.taobao.org/mirrors/node/v6.11.1/node-v6.11.1-win-x86.7z'
$Checksum32 = '117bdeec7008492e2b313b637773375f07bf9582d13083566d3ad5e089f30875'
$ChecksumType32 = 'sha256'
$Url64 = 'https://npm.taobao.org/mirrors/node/v6.11.1/node-v6.11.1-win-x64.7z'
$Checksum64 = '22adcce6cbf2e40a879906be662f1818073f4668964d3b4ce544da56c17051f9'
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
