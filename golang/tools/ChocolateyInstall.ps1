$ErrorActionPreference = 'Stop';

$PackageName = 'golang'
$Url32 = 'https://storage.googleapis.com/golang/go1.8.3.windows-386.zip'
$Checksum32 = '9e2bfcb8110a3c56f23b91f859963269bc29fd114190fecfd0a539395272a1c7'
$ChecksumType32 = 'SHA256'
$Url64 = 'https://storage.googleapis.com/golang/go1.8.3.windows-amd64.zip'
$Checksum64 = 'de026caef4c5b4a74f359737dcb2d14c67ca45c45093755d3b0d2e0ee3aafd96'
$ChecksumType64 = 'SHA256'
$installationPath = Get-ToolsLocation

$PackageArgs = @{
    PackageName    = $PackageName
    url            = $Url32
    Checksum       = $Checksum32
    ChecksumType   = $ChecksumType32
    url64          = $Url64
    Checksum64     = $Checksum64
    ChecksumType64 = $ChecksumType64
    UnzipLocation  = $installationPath
}
Install-ChocolateyZipPackage @PackageArgs

$GOROOT = Join-Path $installationPath 'go'
$GOPATH = Join-Path $GOROOT 'opt'
$GOBIN = Join-Path $GOROOT 'bin'
Install-ChocolateyEnvironmentVariable -VariableName 'GOROOT' -VariableValue $GOROOT -VariableType 'Machine'
Install-ChocolateyEnvironmentVariable -VariableName 'GOPATH' -VariableValue $GOPATH -VariableType 'Machine'
Install-ChocolateyPath -PathToInstall $GOBIN -PathType 'Machine'
