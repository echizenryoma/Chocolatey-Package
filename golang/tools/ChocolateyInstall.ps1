$ErrorActionPreference = 'Stop'

$PackageName = 'go'
$Url32 = 'https://storage.googleapis.com/golang/go1.12.5.windows-386.zip'
$Url64 = 'https://storage.googleapis.com/golang/go1.12.5.windows-amd64.zip'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Join-Path $InstallationPath 'tmp'

if (Test-Path $InstallationPath) {
    Get-ChildItem -Path $InstallationPath -exclude 'opt' | Remove-Item -Recurse -Force -ErrorAction Ignore
}

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$UnzipPath = (Get-ChildItem $UnzipLocation -Directory | Where-Object Name -Match "${PackageName}" | Select-Object -First 1).FullName
Copy-Item -Path $(Join-Path $UnzipPath '*') -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore

$GOROOT = Join-Path $InstallationPath $PackageName
$GOPATH = Join-Path $GOROOT 'opt'
$GOBIN = Join-Path $GOROOT 'bin'
Install-ChocolateyEnvironmentVariable -VariableName 'GOROOT' -VariableValue $GOROOT -VariableType 'Machine'
Install-ChocolateyEnvironmentVariable -VariableName 'GOPATH' -VariableValue $GOPATH -VariableType 'Machine'
Install-ChocolateyPath -PathToInstall $GOBIN -PathType 'Machine'
