$ErrorActionPreference = 'Stop'

$PackageName = 'jdk8'
$Url32 = 'http://edelivery.oracle.com/otn-pub/java/jdk/8u192-b12/750e1c8617c5452694857ad95c3ee230/jdk-8u192-windows-i586.exe'
$Checksum32 = 'd4d5bcfd8e3318de9d22fd7f6f1f71df44ce4084e7ff31407492889ef600f1a2'
$ChecksumType32 = 'sha256'
$Url64 = 'http://edelivery.oracle.com/otn-pub/java/jdk/8u192-b12/750e1c8617c5452694857ad95c3ee230/jdk-8u192-windows-x64.exe'
$Checksum64 = '588d0882646eaf43b6ac9e40e7de4fb6045632ce49158521980cc632d42032cd'
$ChecksumType64 = 'sha256'
$JavaVersion = '8u192'
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
