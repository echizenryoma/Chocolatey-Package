$ErrorActionPreference = 'Stop'

$PackageName = 'fiddler'
$Url = 'https://telerik-fiddler.s3.amazonaws.com/fiddler/FiddlerSetup.exe'
$Checksum = '2AFE37AB5CDB7DF4A80FCBE85B9298F509DF064173E6A4EE7008E5D409BC6172'
$ChecksumType = 'sha256'

$PackageArgs = @{
    PackageName  = $PackageName
    Url          = $Url
    Checksum     = $Checksum 
    ChecksumType = $ChecksumType
    SilentArgs   = '/S'
}
Install-ChocolateyPackage @PackageArgs
