$ErrorActionPreference = 'Stop'

$PackageName = 'k-litecodecpack.mega'
$Url32 = 'https://files3.codecguide.com/K-Lite_Codec_Pack_1750_Mega.exe'
$Checksum32 = 'e03ba52f74cea09aacbd87b5fbc19812aa83b6eb38a968dda34c67eab530a7e9'
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
