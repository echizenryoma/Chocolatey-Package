$ErrorActionPreference = 'Stop'

$PackageName = 'jdk'
$Url64 = 'https://edelivery.oracle.com/otn-pub/java/jdk/11.0.2+7/f51449fcd52f4d52b93a989c5c56ed3c/jdk-11.0.2_windows-x64_bin.zip'
$Checksum64 = 'e5306bf87dfeb070c7bd0aa4623f10d196e0667fb1cc818202d33fcee77bce4c'
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
