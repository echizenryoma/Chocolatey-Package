$ErrorActionPreference = 'Stop'

$PackageName = 'NirSoft'
$Url = 'https://download.nirsoft.net/nirsoft_package_enc_1.23.64.zip'
$Checksum = '3fbeda90bc3ea8cb6ad65246050bad360c6ade1cc6cf24f71e936b8945204941'
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
