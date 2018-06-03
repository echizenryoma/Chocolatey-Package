$ErrorActionPreference = 'Stop'

$PackageName = 'GoldenDict'
$Url32 = 'https://sourceforge.net/projects/goldendict/files/early%20access%20builds/Qt5-based/GoldenDict-1.5.0-RC2-311-g15062f7_%28QT_595%29.7z/download'
$Url64 = 'https://sourceforge.net/projects/goldendict/files/early%20access%20builds/Qt5-based/64bit/GoldenDict-1.5.0-RC2-311-g15062f7_%28QT_595%29%2864bit%29.7z/download'
$InstallationPath = Get-ToolsLocation

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs
