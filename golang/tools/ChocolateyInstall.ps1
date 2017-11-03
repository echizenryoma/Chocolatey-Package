$ErrorActionPreference = 'Stop'

$PackageName = 'golang'
$Url32 = 'https://storage.googleapis.com/golang/go1.9.2.windows-386.zip'
$Checksum32 = '35d3be5d7b97c6d11ffb76c1b19e20a824e427805ee918e82c08a2e5793eda20'
$ChecksumType32 = 'SHA256'
$Url64 = 'https://storage.googleapis.com/golang/go1.9.2.windows-amd64.zip'
$Checksum64 = '682ec3626a9c45b657c2456e35cadad119057408d37f334c6c24d88389c2164c'
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
    Url            = $Url32
    Checksum       = $Checksum32
    ChecksumType   = $ChecksumType32
    Url64          = $Url64
    Checksum64     = $Checksum64
    ChecksumType64 = $ChecksumType64
    UnzipLocation  = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

Install-ChocolateyEnvironmentVariable -VariableName 'GOROOT' -VariableValue $GOROOT -VariableType 'Machine'
Install-ChocolateyEnvironmentVariable -VariableName 'GOPATH' -VariableValue $GOPATH -VariableType 'Machine'
Install-ChocolateyPath -PathToInstall $GOBIN -PathType 'Machine'
