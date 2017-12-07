$ErrorActionPreference = 'Stop'

$PackageName = 'tomcat'
$Url32 = 'https://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-8/v8.5.24/bin/apache-tomcat-8.5.24-windows-x86.zip'
$Url64 = 'https://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-8/v8.5.24/bin/apache-tomcat-8.5.24-windows-x64.zip'
$InstallationPath = Get-ToolsLocation
$ToolsPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

if (-Not (Test-Path $ToolsPath)) {
    New-Item -ItemType Directory -Force -Path $ToolsPath
}

$UnzipPath = (Get-ChildItem $InstallationPath -Directory | Where-Object Name -Like "apache-tomcat-*" | Select-Object -First 1).FullName
cmd /c xcopy $UnzipPath $ToolsPath /s /y /q
cmd /c rmdir "$UnzipPath" /s /q
