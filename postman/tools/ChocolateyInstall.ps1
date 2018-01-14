$ErrorActionPreference = 'Stop'

$PackageName = 'postman'
$Url32 = 'https://dl.pstmn.io/download/latest/win32'
$Url64 = 'https://dl.pstmn.io/download/latest/win64'

$PackageArgs = @{
    PackageName = $PackageName
    FileType    = "EXE"
    SilentArgs  = "-s"
    Url         = $Url32
    Url64       = $Url64
}
Install-ChocolateyPackage @PackageArgs
