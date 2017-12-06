$ErrorActionPreference = 'Stop'

$PackageName = 'fiddler'
$Url = 'https://telerik-fiddler.s3.amazonaws.com/fiddler/FiddlerSetup.exe'
$Checksum = 'D0FC79707ABA5CBA52B4B8AE28E289CAC7C20BCF94EF1BE323E6DB87079036AA'
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
