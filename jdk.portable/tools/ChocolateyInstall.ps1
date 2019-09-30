$ErrorActionPreference = 'Stop'

$PackageName = 'jdk'
$Url64 = 'https://edelivery.oracle.com/otn-pub/java/jdk/13+33/5b8a42f3905b406298b72d750b6919f6/jdk-13_windows-x64_bin.zip'
$Checksum64 = '372a7b94fe9066c2776adb52fef5daa8404a364ef21b2045f7ebdcb1b9b02bc3'
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
