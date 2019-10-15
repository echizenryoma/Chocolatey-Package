$ErrorActionPreference = 'Stop'

$PackageName = 'jdk'
$Url64 = 'https://edelivery.oracle.com/otn-pub/java/jdk/13.0.1+9/cec27d702aa74d5a8630c65ae61e4305/jdk-13.0.1_windows-x64_bin.zip'
$Checksum64 = 'fda3b4dfe72e857a5714c9719e4ccc957d35bbf8df99f47221e508ac09852d3d'
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
