$ErrorActionPreference = 'Stop'

$PackageName = 'k-litecodecpack.mega'
$Url32 = 'https://files3.codecguide.com/K-Lite_Codec_Pack_1509_Mega.exe'
$Checksum32 = '46983a6fe8cbdc2089c0d360bfeebcf0639bf5846ea47bcff9aed96dc5e6f176'
$ChecksumType32 = 'sha256'
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
