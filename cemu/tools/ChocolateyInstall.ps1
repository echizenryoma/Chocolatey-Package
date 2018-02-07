$ErrorActionPreference = 'Stop'

$PackageName = 'cemu'
$Url64 = 'http://cemu.info/releases/cemu_1.11.4.zip'
$UnzipLocation = Get-ToolsLocation
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName    = $PackageName
    Url64          = $Url64
    UnzipLocation  = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$null = New-Item -ItemType Directory -Force -Path $InstallationPath -ErrorAction Ignore
$UnzipPath = Join-Path $UnzipLocation $([IO.Path]::GetFileNameWithoutExtension($Url64))
Start-ChocolateyProcessAsAdmin -ExeToRun 'xcopy' -Statements "`"$UnzipPath`" `"$InstallationPath`" /s /y /q"
Remove-Item -Path $UnzipPath -Recurse -Force -ErrorAction Ignore
