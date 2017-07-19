$ErrorActionPreference = 'Stop'

$PackageName = 'jdk'
$Url32 = 'http://edelivery.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-windows-i586.exe'
$Checksum32 = 'f144354be4bc0df7bba6e97e5c2602b743a87604717d11417de6a1445cfab1e5'
$ChecksumType32 = 'SHA256'
$Url64 = 'http://edelivery.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-windows-x64.exe'
$Checksum64 = '0e422f42b5085d463bb5096a77084de863c64618905d63e7133bbbb6958a23fd'
$ChecksumType64 = 'SHA256'
$JavaVersion = '1.8.0_141'

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $Url32
    Checksum       = $Checksum32
    ChecksumType   = $ChecksumType32
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

if ($env:chocolateyForceX86 -ne $True) {
    $JAVA_HOME = Join-Path $env:ProgramFiles "Java\jdk$JavaVersion"
}
else {
    $JAVA_HOME = Join-Path ${env:ProgramFiles(x86)} "Java\jdk$JavaVersion"
}
Install-ChocolateyEnvironmentVariable -VariableName 'JAVA_HOME' -VariableValue $JAVA_HOME -VariableType 'Machine'
