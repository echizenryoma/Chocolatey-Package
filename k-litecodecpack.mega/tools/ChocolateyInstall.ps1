$ErrorActionPreference = 'Stop'

$PackageName = 'k-litecodecpack.mega'
$Url32 = 'https://files2.codecguide.com/K-Lite_Codec_Pack_1725_Mega.exe'
$Checksum32 = 'ed908764311e8254ce7dc34ac01af0f45464a8e40c17e5af13a96fc4165fa793'
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
