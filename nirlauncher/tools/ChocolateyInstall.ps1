$ErrorActionPreference = 'Stop'

$PackageName = 'NirSoft'
$Url = 'https://download.nirsoft.net/nirsoft_package_enc_1.23.60.zip'
$Checksum = '0d6a266275c98f95ab79fdacfb6098c8c3bcee095915f06b401025f7a7fb0c08'
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
