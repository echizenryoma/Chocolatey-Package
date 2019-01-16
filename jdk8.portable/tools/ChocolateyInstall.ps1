$ErrorActionPreference = 'Stop'

$PackageName = 'jdk8'
$Url32 = 'https://edelivery.oracle.com/otn-pub/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/jdk-8u202-windows-i586.exe'
$Checksum32 = '88d6f861cc57866bfe85889798f18e0a0771ec0283ed81f3288049eb98d7c285'
$ChecksumType32 = 'sha256'
$Url64 = 'https://edelivery.oracle.com/otn-pub/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/jdk-8u202-windows-x64.exe'
$Checksum64 = 'b3bcdd6007e30c7b9d459b5bef766ac49f1e0b1cc92b11b19af3cf0439c3bc9f'
$ChecksumType64 = 'sha256'
$JavaVersion = '8u202'
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
