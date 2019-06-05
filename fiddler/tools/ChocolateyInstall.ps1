$ErrorActionPreference = 'Stop'

$PackageName = 'fiddler'
$Url = 'https://telerik-fiddler.s3.amazonaws.com/fiddler/FiddlerSetup.exe'
$Checksum = '4DFF6CB1B88A503D3982C7CCBCD5622496EBA4C21AAB5A2C0C0F1E376A2EB809'
$ChecksumType = 'sha256'

$PackageArgs = @{
    PackageName  = $PackageName
    Url          = $Url
    Checksum     = $Checksum 
    ChecksumType = $ChecksumType
    SilentArgs   = '/S'
}
Install-ChocolateyPackage @PackageArgs
