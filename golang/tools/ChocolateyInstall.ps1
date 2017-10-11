$ErrorActionPreference = 'Stop'

$PackageName = 'golang'
$Url32 = 'https://storage.googleapis.com/golang/go1.9.1.windows-386.zip'
$Checksum32 = 'ea9c79c9e6214c9a78a107ef5a7bff775a281bffe8c2d50afa66d2d33998078a'
$ChecksumType32 = 'SHA256'
$Url64 = 'https://storage.googleapis.com/golang/go1.9.1.windows-amd64.zip'
$Checksum64 = '8dc72a3881388e4e560c2e45f6be59860b623ad418e7da94e80fee012221cc81'
$ChecksumType64 = 'SHA256'
$InstallationPath = Get-ToolsLocation

$GOROOT = Join-Path $InstallationPath 'go'
$GOPATH = Join-Path $GOROOT 'opt'
$GOBIN = Join-Path $GOROOT 'bin'

if (Test-Path $GOROOT) {
    Get-ChildItem -Path $GOROOT -exclude 'opt' |
        Remove-Item -Recurse -Force | Out-Null
}

$PackageArgs = @{
    PackageName    = $PackageName
    url            = $Url32
    Checksum       = $Checksum32
    ChecksumType   = $ChecksumType32
    url64          = $Url64
    Checksum64     = $Checksum64
    ChecksumType64 = $ChecksumType64
    UnzipLocation  = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

Install-ChocolateyEnvironmentVariable -VariableName 'GOROOT' -VariableValue $GOROOT -VariableType 'Machine'
Install-ChocolateyEnvironmentVariable -VariableName 'GOPATH' -VariableValue $GOPATH -VariableType 'Machine'
Install-ChocolateyPath -PathToInstall $GOBIN -PathType 'Machine'
