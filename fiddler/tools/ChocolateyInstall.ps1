$ErrorActionPreference = 'Stop'

$PackageName = 'fiddler'
$Url = 'https://telerik-fiddler.s3.amazonaws.com/fiddler/FiddlerSetup.exe'
$Checksum = '1E42133A348BF6889D92F7880C9C40FCBA558F83EA0720E74375AF6FA8184F07'
$ChecksumType = 'SHA256'

$packageArgs = @{
    PackageName    = $PackageName
    Url            = $Url
    Checksum       = $Checksum 
    ChecksumType   = $ChecksumType
    SilentArgs     = '/S'
    ValidExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
