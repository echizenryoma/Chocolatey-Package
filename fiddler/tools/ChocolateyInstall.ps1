$ErrorActionPreference = 'Stop'

$PackageName = 'fiddler'
$Url = 'https://telerik-fiddler.s3.amazonaws.com/fiddler/FiddlerSetup.exe'
$Checksum = '67C79B9F7F7E7467E27B61F624D9F12EFFC0556CAAD4DACCE2EA08E19C212314'
$ChecksumType = 'SHA256'

$packageArgs = @{
    PackageName  = $PackageName
    Url          = $Url
    Checksum     = $Checksum 
    ChecksumType = $ChecksumType
    SilentArgs   = '/S'
}
Install-ChocolateyPackage @packageArgs
