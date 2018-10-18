$ErrorActionPreference = 'Stop'

$PackageName = 'jdk'
$Url64 = 'http://edelivery.oracle.com/otn-pub/java/jdk/11.0.1+13/90cf5d8f270a4347a95050320eef3fb7/jdk-11.0.1_windows-x64_bin.zip'
$Checksum64 = '0bdc75f64e07387e3d303684041898bffd0bb60e8e2cce84cb152042026ed5a7'
$ChecksumType64 = 'sha256'
$FileName = (([IO.Path]::GetFileNameWithoutExtension($Url64)) -split "_")[0]
$InstallationPath = Join-Path $(Get-ToolsLocation) $FileName

$PackageArgs = @{
    PackageName    = $PackageName
    Url64          = $Url64
    Checksum64     = $Checksum64
    ChecksumType64 = $ChecksumType64
    UnzipLocation  = $(Get-ToolsLocation)
    FileType       = ([IO.Path]::GetExtension($Url64)) -replace "\.", ""
    Options        = @{
        Headers = @{
            Cookie = 'oraclelicense=accept-securebackup-cookie'
        }
    }
}
Install-ChocolateyZipPackage @PackageArgs

$JAVA_HOME = $InstallationPath
Install-ChocolateyEnvironmentVariable -VariableName 'JAVA_HOME' -VariableValue $JAVA_HOME -VariableType 'Machine'

Install-ChocolateyPath -PathToInstall $(Join-Path $JAVA_HOME 'bin') -PathType 'Machine'
