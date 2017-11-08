$ErrorActionPreference = 'Stop'

$PackageName = 'nodejs'
$Url32 = 'https://npm.taobao.org/mirrors/node/v8.9.1/node-v8.9.1-win-x86.7z'
$Checksum32 = 'a30b6a56d424f8a34e65fe8f197a6db17dee6fa10ed50ffdf8490ca0787d995a'
$ChecksumType32 = 'sha256'
$Url64 = 'https://npm.taobao.org/mirrors/node/v8.9.1/node-v8.9.1-win-x64.7z'
$Checksum64 = 'ff28dd5ff5a09a904e364742b58011af33d0a3fe148831e55b2c60f1bc251569'
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
