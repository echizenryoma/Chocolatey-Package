$ErrorActionPreference = 'Stop'

$PackageName = 'openjdk'
$Url64 = 'https://download.java.net/java/GA/jdk14.0.2/205943a0976c4ed48cb16f1043c5c647/11/GPL/openjdk-14.0.2_windows-x64_bin.zip'
$InstallationPath = Get-ToolsLocation

$JdkVersion = ($Url64 -split "/|_" -match "openjdk-\d+(\.\d+)+")[0] -replace "openjdk", "jdk"
$UnzipLocation = Join-Path $(Get-ToolsLocation) $JdkVersion
if (Test-Path $UnzipLocation) {
    Remove-Item -Path $UnzipLocation -Force -Recurse
}

$PackageArgs = @{
    PackageName    = $PackageName
    Url64          = $Url64
    UnzipLocation  = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

$JAVA_HOME = $UnzipLocation
Install-ChocolateyEnvironmentVariable -VariableName 'JAVA_HOME' -VariableValue $JAVA_HOME -VariableType 'Machine'

Install-ChocolateyPath -PathToInstall $(Join-Path $JAVA_HOME 'bin') -PathType 'Machine'
