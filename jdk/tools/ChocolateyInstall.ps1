$ErrorActionPreference = 'Stop'

$PackageName = 'jdk'
$Url64 = 'http://edelivery.oracle.com/otn-pub/java/jdk/9.0.1+11/jdk-9.0.1_windows-x64_bin.exe'
$Checksum64 = '4df5f74fe04c708977e23bdae8842297bce10d550e4a1cbedde9a33af56f4dab'
$ChecksumType64 = 'SHA256'
$JavaVersion = '9'

$PackageArgs = @{
    PackageName    = $PackageName
    Url64          = $Url64
    Checksum64     = $Checksum64
    ChecksumType64 = $ChecksumType64
    FileType       = 'exe'
    SilentArgs     = '/s'
    Options        = @{
        Headers = @{
            Cookie = 'oraclelicense=accept-securebackup-cookie'
        }
    }
}
Install-ChocolateyPackage @PackageArgs

$JAVA_HOME = Join-Path $env:ProgramFiles "Java\jdk-$JavaVersion"
Install-ChocolateyEnvironmentVariable -VariableName 'JAVA_HOME' -VariableValue $JAVA_HOME -VariableType 'Machine'

Install-ChocolateyPath -PathToInstall $(Join-Path $JAVA_HOME 'bin') -PathType 'Machine'
