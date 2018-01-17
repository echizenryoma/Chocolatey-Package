$ErrorActionPreference = 'Stop'

$PackageName = 'jdk8'
$Url32 = 'http://edelivery.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-8u162-windows-i586.exe'
$Checksum32 = '4a705bd74171eb003a1485d1b2d7a3fb735452f252d39a7beee5117f08614c1f'
$ChecksumType32 = 'SHA256'
$Url64 = 'http://edelivery.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-8u162-windows-x64.exe'
$Checksum64 = 'f05aa9904c373b2e0aad7a5ce1006aa3aff096842f256d66c6cfc268d9c48026'
$ChecksumType64 = 'SHA256'
$JavaVersion = '8u162'
$InstallationPath = Join-Path $(Get-ToolsLocation) "jdk_$JavaVersion"
$UnzipPath = $(Join-Path $InstallationPath "tmp")

$PackageArgs = @{
    PackageName    = $PackageName
    Url32          = $Url32
    Checksum32     = $Checksum32
    ChecksumType32 = $ChecksumType32
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

$JdkFilesPath = Get-ChildItem -Path $UnzipPath -File -Recurse | Sort-Object Length -Descending | Select-Object -First 3
$JdkToolsPath = $JdkFilesPath[0].FullName
$JdkSrcPath = $JdkFilesPath[2].FullName

$PackageArgs = @{
    PackageName   = $PackageName
    Url32         = $JdkToolsPath
    Url64         = $JdkToolsPath
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

$PackageArgs = @{
    PackageName   = $PackageName
    Url32         = $JdkSrcPath
    Url64         = $JdkSrcPath
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

Remove-Item -Path $UnzipPath -Recurse -Force -ErrorAction Ignore

$JdkToolsPath = (Get-ChildItem -Path $InstallationPath -File -Recurse | Sort-Object Length -Descending | Select-Object -First 1).FullName
$PackageArgs = @{
    PackageName   = $PackageName
    Url32         = $JdkToolsPath
    Url64         = $JdkToolsPath
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs
Remove-Item -Path $JdkToolsPath -Force -ErrorAction Ignore

$UnpackFiles = Get-ChildItem -Path $InstallationPath -Filter "*.pack" -Recurse
ForEach ($UnpackFile in $UnpackFiles) {
    $src = $UnpackFile.FullName
    $dst = Join-Path $UnpackFile.Directory.FullName $("{0}.{1}" -f $UnpackFile.BaseName, "jar")
    & "$InstallationPath\bin\unpack200.exe" -r -v "$src" "$dst"
}
