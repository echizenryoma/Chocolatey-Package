$ErrorActionPreference = 'Stop'

$PackageName = 'jdk'
$Url32 = 'http://edelivery.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-windows-i586.exe'
$Checksum32 = 'f2c6657812986aa4b992173da495cdc3620edcdc26927860d7d920958f12575c'
$ChecksumType32 = 'SHA256'
$Url64 = 'http://edelivery.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-windows-x64.exe'
$Checksum64 = 'be9f6e920f817757ce1913c9c3f0a5d63046c720f37a95e4a14450a179f48a18'
$ChecksumType64 = 'SHA256'
$JavaVersion = '1.8.0_144'

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
