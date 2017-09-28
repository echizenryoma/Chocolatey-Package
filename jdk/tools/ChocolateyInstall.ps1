$ErrorActionPreference = 'Stop'

$PackageName = 'jdk'
$Url64 = 'http://edelivery.oracle.com/otn-pub/java/jdk/9+181/jdk-9_windows-x64_bin.exe'
$Checksum64 = 'd4885a5fbd2dce383c579fe4a1569b6d8b5db1574af602e37cadcac781115297'
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
