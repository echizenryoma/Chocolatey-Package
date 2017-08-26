$ErrorActionPreference = 'Stop';

$PackageName = 'golang'
$Url32 = 'https://storage.googleapis.com/golang/go1.9.windows-386.zip'
$Checksum32 = 'ecfe6f5be56acedc56cd9ff735f239a12a7c94f40b0ea9753bbfd17396f5e4b9'
$ChecksumType32 = 'SHA256'
$Url64 = 'https://storage.googleapis.com/golang/go1.9.windows-amd64.zip'
$Checksum64 = '874b144b994643cff1d3f5875369d65c01c216bb23b8edddf608facc43966c8b'
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
