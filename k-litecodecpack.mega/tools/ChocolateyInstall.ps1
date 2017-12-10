$ErrorActionPreference = 'Stop'

$PackageName = 'k-litecodecpack.mega'
$Url32 = 'http://files2.codecguide.com/K-Lite_Codec_Pack_1370_Mega.exe'
$Checksum32 = '897d649bb1dc04b9b2da37c4189a2b793dff50c4ee30d432e6029d71a9f3f4fb'
$ChecksumType32 = 'SHA256'

$PackageArgs = @{
    InstallerType = 'EXE'
    PackageName   = $PackageName
    Url           = $Url32
    Checksum      = $Checksum32
    ChecksumType  = $ChecksumType32
    SilentArgs    = '/VERYSILENT'
}
Install-ChocolateyPackage @PackageArgs
