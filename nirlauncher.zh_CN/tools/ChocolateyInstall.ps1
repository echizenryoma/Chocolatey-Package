$ErrorActionPreference = 'Stop'

$PackageName = 'NirSoft'
$Url = 'https://download.nirsoft.net/nirsoft_package_schinese.zip'
$Checksum = '3e44905d834613e184ee5ebb097a3674b623caea1c92ecb51187aef69df2b4f8'
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
