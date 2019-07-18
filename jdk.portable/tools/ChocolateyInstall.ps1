$ErrorActionPreference = 'Stop'

$PackageName = 'jdk'
$Url64 = 'https://edelivery.oracle.com/otn-pub/java/jdk/12.0.2+10/e482c34c86bd4bf8b56c0b35558996b9/jdk-12.0.2_windows-x64_bin.zip'
$Checksum64 = '306a1e44b1584b720bb99194d302a7652c28db608cfba5df38586985d835c6bd'
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
