$ErrorActionPreference = 'Stop'

$PackageName = 'jdk8'
$Url32 = 'https://edelivery.oracle.com/otn/java/jdk/8u212-b10/59066701cf1a433da9770636fbc4c9aa/jdk-8u212-windows-i586.exe'
$Checksum32 = '2ea45edb83303d87cabef2e872abb8a7c80da578e4e7a468bd27d9e3b8595b1b'
$ChecksumType32 = 'sha256'
$Url64 = 'https://edelivery.oracle.com/otn/java/jdk/8u212-b10/59066701cf1a433da9770636fbc4c9aa/jdk-8u212-windows-x64.exe'
$Checksum64 = '330a6396fcc97c57a951170bb9ac5a00b75974da8f002cb7e62fdf09d15018c5'
$ChecksumType64 = 'sha256'
$JavaVersion = '8u212'
$InstallationPath = Join-Path $(Get-ToolsLocation) "jdk_$JavaVersion"
$UnzipPath = $(Join-Path $InstallationPath "tmp")

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $Url32
    Checksum       = $Checksum32
    ChecksumType   = $ChecksumType32
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
    Url           = $JdkToolsPath
    Url64         = $JdkToolsPath
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $JdkSrcPath
    Url64         = $JdkSrcPath
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

Remove-Item -Path $UnzipPath -Recurse -Force -ErrorAction Ignore

$JdkToolsPath = (Get-ChildItem -Path $InstallationPath -File -Recurse | Sort-Object Length -Descending | Select-Object -First 1).FullName
$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $JdkToolsPath
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
