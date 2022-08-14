$ErrorActionPreference = 'Stop'

$PackageName = 'NirSoft'
$Url = 'https://download.nirsoft.net/nirsoft_package_schinese.zip'
$Checksum = '42ecf561e4293fe3dd0ca3554e74fc0259413c6d21535ec84658f76a0a456fea'
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
