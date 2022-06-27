$ErrorActionPreference = 'Stop'

$PackageName = 'k-litecodecpack.mega'
$Url32 = 'https://files2.codecguide.com/K-Lite_Codec_Pack_1710_Mega.exe'
$Checksum32 = '374f0696cdaf6504d32e4a08aec71558dde82aef426b9eb1fc23cff3639f3493'
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
