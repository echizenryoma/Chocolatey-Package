$ErrorActionPreference = 'Stop'

$PackageName = 'NirSoft'
$Url = 'https://download.nirsoft.net/nirsoft_package_enc_1.23.63.zip'
$Checksum = '85b2b10452b8a00e9a3a0e8497a8880c06cfa535e1158eab5010170b5f9f402c'
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
