$ErrorActionPreference = 'Stop'

$PackageName = 'NirSoft'
$Url = 'https://download.nirsoft.net/nirsoft_package_schinese.zip'
$Checksum = 'c9e0a9bc74d1fcc1d853a6bd6ae59e9362aee80549e87aa1ec8f4e8a61fcd258'
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
