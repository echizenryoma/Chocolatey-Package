$ErrorActionPreference = 'Stop'

$PackageName = 'k-litecodecpack.mega'
$Url32 = 'https://files3.codecguide.com/K-Lite_Codec_Pack_1755_Mega.exe'
$Checksum32 = '27e879aaf9f13b222508be709b63f9365c85869e1f7cd7659bcf389a5de5ae8b'
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
