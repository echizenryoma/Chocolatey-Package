$ErrorActionPreference = 'Stop'

$PackageName = 'jdk'
$Url64 = 'http://edelivery.oracle.com/otn-pub/java/jdk/9.0.4+11/c2514751926b4512b076cc82f959763f/jdk-9.0.4_windows-x64_bin.exe'
$Checksum64 = '56c67197a8f2f7723ffb0324191151075cdec0f0891861e36f3fadda28d556c3'
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
