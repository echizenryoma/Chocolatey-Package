$ErrorActionPreference = 'Stop'

$PackageName = 'fiddler'
$Url = 'https://telerik-fiddler.s3.amazonaws.com/fiddler/FiddlerSetup.exe'
$Checksum = '9E51CB26AB9DCA6398A65FC8F3B44C762CB8E75AF9F1B824AE080A07BC53C1DA'
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
