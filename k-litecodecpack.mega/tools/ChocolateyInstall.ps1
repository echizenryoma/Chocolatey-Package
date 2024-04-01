$ErrorActionPreference = 'Stop'

$PackageName = 'k-litecodecpack.mega'
$Url32 = 'https://files2.codecguide.com/K-Lite_Codec_Pack_1826_Mega.exe'
$Checksum32 = '647e52780d2d9809b5b284a1fda4c0f227ef53723d7b1ff1643f00c50c03a535'
$ChecksumType32 = 'sha256'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$SetupInfPath = Join-Path $ToolsPath 'setup.inf'
$SilentArgs = "/VERYSILENT /NORESTART /SUPPRESSMSGBOXES /LOADINF=`"$SetupInfPath`""

$PackageArgs = @{
    PackageName  = $PackageName
    Url          = $Url32
    Checksum     = $Checksum32
    ChecksumType = $ChecksumType32
    SilentArgs   = $SilentArgs
}
Install-ChocolateyPackage @PackageArgs
