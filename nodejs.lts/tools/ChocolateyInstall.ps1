$ErrorActionPreference = 'Stop';

$PackageName = 'nodejs'
$Url32 = 'https://npm.taobao.org/mirrors/node/v6.11.2/node-v6.11.2-win-x86.7z'
$Checksum32 = 'e38c74a43f72cce05caeaf77afb49f6979345b7a891abdcd5d9e4b72d34cc710'
$ChecksumType32 = 'sha256'
$Url64 = 'https://npm.taobao.org/mirrors/node/v6.11.2/node-v6.11.2-win-x64.7z'
$Checksum64 = '9189de5ef26e40bc77c2f999368a136c8dfb13d16298c0037a7cd2135adee4be'
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
