$ErrorActionPreference = 'Stop'

$PackageName = 'tomcat'
$Url32 = 'https://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-8/v8.5.27/bin/apache-tomcat-8.5.27-windows-x86.zip'
$Url64 = 'https://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-8/v8.5.27/bin/apache-tomcat-8.5.27-windows-x64.zip'
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
$UnzipPath = (Get-ChildItem $InstallationPath -Directory | Where-Object Name -Like "apache-tomcat-*" | Select-Object -First 1).FullName
Start-ChocolateyProcessAsAdmin -ExeToRun 'xcopy' -Statements "`"$UnzipPath`" `"$InstallationPath`" /s /y /q"
Start-ChocolateyProcessAsAdmin -ExeToRun 'rmdir' -Statements "`"$UnzipPath`" /s /q"
