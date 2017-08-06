$ErrorActionPreference = 'Stop'

$PackageName = 'opencv'
$Url64 = 'https://github.com/opencv/opencv/releases/download/3.3.0/opencv-3.3.0-vc14.exe'
$InstallationPath = Get-ToolsLocation

$OpenCV_HOME = Join-Path $installationPath 'opencv'
if (Test-Path $OpenCV_HOME) {
    Remove-Item -Path $OpenCV_HOME -Recurse -Force
}

$PackageArgs = @{
    PackageName   = $PackageName
    Url64         = $Url64
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

$EnvPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine) -split ';' -notmatch 'opencv'
[Environment]::SetEnvironmentVariable('Path', $EnvPath -join ';', [EnvironmentVariableTarget]::Machine)

$OpenCV_BIN = Get-ChildItem $OpenCV_HOME -Include "bin" -Directory -Recurse
foreach ($bin in $OpenCV_BIN) {
    Install-ChocolateyPath -PathToInstall $bin -PathType 'Machine'
}

$OpenCV_HOME = Join-Path $OpenCV_HOME 'build'
Install-ChocolateyEnvironmentVariable -VariableName 'OpenCV_DIR' -VariableValue $OpenCV_HOME -VariableType 'Machine'

$OpenCV_LIB = Get-ChildItem $OpenCV_HOME -Include "lib" -Directory -Recurse
Install-ChocolateyEnvironmentVariable -VariableName 'OpenCV_LIBS' -VariableValue $OpenCV_LIB -VariableType 'Machine'

$OpenCV_INCLUDE = Get-ChildItem $OpenCV_HOME -Include "include" -Directory -Recurse
Install-ChocolateyEnvironmentVariable -VariableName 'OpenCV_INCLUDE_DIRS' -VariableValue $OpenCV_INCLUDE -VariableType 'Machine'
