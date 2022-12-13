$ErrorActionPreference = 'Stop'

$PackageName = 'NirSoft'
$Url = 'https://download.nirsoft.net/nirsoft_package_enc_1.23.68.zip'
$Checksum = 'fe3d945a948c1d7cdaa7ba75804a55dd2f176e77b62f1655150fd720bdb91fff'
$ChecksumType = 'sha256'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipPassword = 'nirsoft9876$'

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $Url
    Checksum       = $Checksum
    ChecksumType   = $ChecksumType
    UnzipLocation  = $InstallationPath
    Options        = @{
        Headers = @{
            Referer = 'https://launcher.nirsoft.net/'
        }
    }
    SpecificFolder = "-p${UnzipPassword}"
}
Install-ChocolateyZipPackage @PackageArgs

$BinName = 'NirLauncher'
$BinFile = Join-Path $InstallationPath "${BinName}.exe"
Install-BinFile -Path ${BinFile} -Name "${BinName}"
