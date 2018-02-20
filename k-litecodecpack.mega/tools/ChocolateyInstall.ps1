$ErrorActionPreference = 'Stop'

$PackageName = 'k-litecodecpack.mega'
$Url32 = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1400_Mega.exe'
$Checksum32 = '071451f3d6509da9a01fcd38724ccf8cf3044d2ba41f24bff18e94a18d206564 9df4d00b828b63fa9b52acb2af5e0bac11daba871d67fda59cb4fbc7656da47d'
$ChecksumType32 = 'SHA256'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$SetupInfPath = Join-Path $ToolsPath 'setup.inf'
$SilentArgs = "/verysilent /norestart /LoadInf=`"$SetupInfPath`""

$PackageArgs = @{
    PackageName  = $PackageName
    Url          = $Url32
    Checksum     = $Checksum32
    ChecksumType = $ChecksumType32
    SilentArgs   = $SilentArgs
}
Install-ChocolateyPackage @PackageArgs
