$ErrorActionPreference = 'Stop'

$PackageName = 'fiddler'
$Url = 'https://telerik-fiddler.s3.amazonaws.com/fiddler/FiddlerSetup.exe'
$Checksum = 'DD9C48E2C37124477320DDEF083DD0FAFCB1B59E0ADE9E881D85FC80EBB82351'
$ChecksumType = 'SHA256'

$packageArgs = @{
    PackageName  = $PackageName
    Url          = $Url
    Checksum     = $Checksum 
    ChecksumType = $ChecksumType
    SilentArgs   = '/S'
}
Install-ChocolateyPackage @packageArgs
