$ErrorActionPreference = 'Stop'

$PackageName = 'NirSoft'
$Url = 'https://download.nirsoft.net/nirsoft_package_enc_1.23.62.zip'
$Checksum = 'b6e966801e642d1e9c03dba697735b49aa01a39872d40b0ea246bd4245d335df'
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
