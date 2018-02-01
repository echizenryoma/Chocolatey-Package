$ErrorActionPreference = 'Stop'

$PackageName = 'k-litecodecpack.mega'
$Url32 = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1380_Mega.exe'
$Checksum32 = 'b053f2c63c7b93f8f472501f08df7578d94f089989a73e326dac990ef5f059bb'
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
