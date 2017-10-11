$PackageName = 'upx'
$Url = 'https://github.com/upx/upx/releases/download/v3.94/upx394w.zip'
$ToolsPath = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $url
    Checksum      = $Checksum
    ChecksumType  = $ChecksumType
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
