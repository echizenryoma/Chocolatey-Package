$ErrorActionPreference = 'Stop'

$PackageName = 'NirSoft'
$Url = 'https://download.nirsoft.net/nirsoft_package_schinese.zip'
$Checksum = '24457e17ee5db070dec5073ef2fbdbe92073e2b5be84719b178d054202367451'
$ChecksumType = 'sha256'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$TmpLocation = Join-Path $InstallationPath 'tmp'
$UnzipLocation = Join-Path $TmpLocation 'language'

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    Checksum      = $Checksum
    ChecksumType  = $ChecksumType
    UnzipLocation = $UnzipLocation
    Options       = @{
        Headers = @{
            Referer = 'https://launcher.nirsoft.net/'
        }
    }
}
Install-ChocolateyZipPackage @PackageArgs

$NirSoftPath = Join-Path $InstallationPath 'NirSoft'
Copy-Item -Path $(Join-Path $UnzipLocation "*") -Destination $NirSoftPath -Force -Recurse
$NirSoft64Path = Join-Path $NirSoftPath 'x64'
Copy-Item -Path $(Join-Path $UnzipLocation "*") -Destination $NirSoft64Path -Force -Recurse

Remove-Item $TmpLocation -Recurse -Force -ErrorAction Ignore
