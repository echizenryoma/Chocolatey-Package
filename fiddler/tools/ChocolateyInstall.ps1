$ErrorActionPreference = 'Stop'

$PackageName = 'fiddler'
$Url = 'https://telerik-fiddler.s3.amazonaws.com/fiddler/FiddlerSetup.exe'
$Checksum = '90650BB4D1801795C80DA27CE28E13707B57642405BCAB9F68C055467AAEF2D2'
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
