$ErrorActionPreference = 'Stop'

$PackageName = 'fiddler'
$Url = 'https://telerik-fiddler.s3.amazonaws.com/fiddler/FiddlerSetup.exe'
$Checksum = 'BCE547BE5B2037A2A0DD80D0639B93A216AEED65CB8C93C25ACE6F9A6743B9E0'
$ChecksumType = 'SHA256'

$packageArgs = @{
    PackageName  = $PackageName
    Url          = $Url
    Checksum     = $Checksum 
    ChecksumType = $ChecksumType
    SilentArgs   = '/S'
}
Install-ChocolateyPackage @packageArgs
