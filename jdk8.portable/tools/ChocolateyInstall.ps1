$ErrorActionPreference = 'Stop'

$PackageName = 'jdk8'
$Url32 = 'http://edelivery.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-windows-i586.exe'
$Checksum32 = '37b090d99104dab7aeae582dbad07731d5550aeb8ebd5eaf0b131e559dd2e30b'
$ChecksumType32 = 'sha256'
$Url64 = 'http://edelivery.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-windows-x64.exe'
$Checksum64 = '6d1e254081d56fa460505d5b0f10ce1e33426c44dfbcab838c2be620f35997a4'
$ChecksumType64 = 'sha256'
$JavaVersion = '8u181'
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

$UnpackFiles = Get-ChildItem -Path $InstallationPath -File -Filter "*.pack" -Recurse
ForEach ($UnpackFile in $UnpackFiles) {
    $src = $UnpackFile.FullName
    $dst = Join-Path $UnpackFile.Directory.FullName $("{0}.{1}" -f $UnpackFile.BaseName, "jar")
    & "$InstallationPath\bin\unpack200.exe" -r -v "$src" "$dst"
}
