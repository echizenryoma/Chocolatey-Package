$ErrorActionPreference = 'Stop'

$PackageName = 'tomcat'
$Url32 = 'https://mirrors.ustc.edu.cn/apache/tomcat/tomcat-9/v9.0.7/bin/apache-tomcat-9.0.7-windows-x86.zip'
$Url64 = 'https://mirrors.ustc.edu.cn/apache/tomcat/tomcat-9/v9.0.7/bin/apache-tomcat-9.0.7-windows-x64.zip'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Get-ToolsLocation

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$null = New-Item -ItemType Directory -Force -Path $InstallationPath -ErrorAction Ignore
$UnzipPath = (Get-ChildItem $UnzipLocation -Directory | Where-Object Name -Like "apache-tomcat-*" | Select-Object -First 1).FullName
$null = Copy-Item -Path $(Join-Path $UnzipPath '*') -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipPath -Recurse -Force -ErrorAction Ignore
