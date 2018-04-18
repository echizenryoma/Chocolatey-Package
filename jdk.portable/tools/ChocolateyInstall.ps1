$ErrorActionPreference = 'Stop'

$PackageName = 'jdk'
$Url64 = 'http://edelivery.oracle.com/otn-pub/java/jdk/10.0.1+10/fb4372174a714e6b8c52526dc134031e/jdk-10.0.1_windows-x64_bin.exe'
$Checksum64 = '9917df90549c8ebc0430dfe92478091ecff05e1a10edc708657e83a987727695'
$ChecksumType64 = 'sha256'
$Version = '10.0.1'
$InstallationPath = Join-Path $(Get-ToolsLocation) "jdk-$Version"
$UnzipPath = $(Join-Path $InstallationPath "tmp")

$PackageArgs = @{
    PackageName    = $PackageName
    Url64          = $Url64
    Checksum64     = $Checksum64
    ChecksumType64 = $ChecksumType64
    UnzipLocation  = $UnzipPath
    FileType       = 'exe'
    Options        = @{
        Headers = @{
            Cookie = 'oraclelicense=accept-securebackup-cookie'
        }
    }
}
Install-ChocolateyZipPackage @PackageArgs

$JdkToolsPath = (Get-ChildItem -Path $UnzipPath -File -Recurse | Sort-Object Length -Descending | Select-Object -First 1).FullName
$PackageArgs = @{
    PackageName   = $PackageName
    Url64         = $JdkToolsPath
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

Remove-Item -Path $UnzipPath -Recurse -Force -ErrorAction Ignore

$UnpackFiles = Get-ChildItem -Path $InstallationPath -File -Filter "*.pack" -Recurse
ForEach ($UnpackFile in $UnpackFiles) {
    $src = $UnpackFile.FullName
    $dst = Join-Path $UnpackFile.Directory.FullName $("{0}.{1}" -f $UnpackFile.BaseName, "jar")
    & "$InstallationPath\bin\unpack200.exe" -r -v "$src" "$dst"
}

$JAVA_HOME = $InstallationPath
Install-ChocolateyEnvironmentVariable -VariableName 'JAVA_HOME' -VariableValue $JAVA_HOME -VariableType 'Machine'

Install-ChocolateyPath -PathToInstall $(Join-Path $JAVA_HOME 'bin') -PathType 'Machine'
