$ErrorActionPreference = 'Stop'

$PackageName = 'nodejs'
$Url32 = 'https://npm.taobao.org/mirrors/node/v8.9.2/node-v8.9.2-win-x86.7z'
$Checksum32 = '17d68bbb061347e55757c25d6016227c03f82db69b802561aefd335e12fb25c9'
$ChecksumType32 = 'sha256'
$Url64 = 'https://npm.taobao.org/mirrors/node/v8.9.2/node-v8.9.2-win-x64.7z'
$Checksum64 = '4046a954c21aa58a209b4c21f981dfa9f15621cc77abc09a6b232b28e28b2c0d'
$ChecksumType64 = 'sha256'
$ToolsPath = $(Get-ToolsLocation)

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $Url32
    Checksum       = $Checksum32
    ChecksumType   = $ChecksumType32
    Url64          = $Url64
    Checksum64     = $Checksum64
    ChecksumType64 = $ChecksumType64
    UnzipLocation  = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

$UnzipPath = (Get-ChildItem $ToolsPath -Directory | Where-Object Name -Like "node-v*-win-x*" | Select-Object -First 1).FullName
$NodejsPath = Join-Path $ToolsPath "nodejs"
cmd /c xcopy $UnzipPath $NodejsPath /s /y /q

Install-ChocolateyPath -PathToInstall $NodejsPath -PathType 'Machine'
cmd /c rmdir "$UnzipPath" /s /q
