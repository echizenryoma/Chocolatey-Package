$ErrorActionPreference = 'Stop'

$PackageName = 'NirSoft'
$Url = 'https://download.nirsoft.net/nirsoft_package_schinese.zip'
$Checksum = '77221ec466dbd751cf01230cb3ba4c2e2dc499b4a2fb36677bfb0577aee4423f'
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
