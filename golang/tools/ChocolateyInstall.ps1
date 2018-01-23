$ErrorActionPreference = 'Stop'

$PackageName = 'golang'
$Url32 = 'https://storage.googleapis.com/golang/go1.9.3.windows-386.zip'
$Url64 = 'https://storage.googleapis.com/golang/go1.9.3.windows-amd64.zip'
$InstallationPath = Get-ToolsLocation

$GOROOT = Join-Path $InstallationPath 'go'
$GOPATH = Join-Path $GOROOT 'opt'
$GOBIN = Join-Path $GOROOT 'bin'

if (Test-Path $GOROOT) {
    $null = Get-ChildItem -Path $GOROOT -exclude 'opt' |  Remove-Item -Recurse -Force
}

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

Install-ChocolateyEnvironmentVariable -VariableName 'GOROOT' -VariableValue $GOROOT -VariableType 'Machine'
Install-ChocolateyEnvironmentVariable -VariableName 'GOPATH' -VariableValue $GOPATH -VariableType 'Machine'
Install-ChocolateyPath -PathToInstall $GOBIN -PathType 'Machine'
