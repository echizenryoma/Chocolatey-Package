$ErrorActionPreference = 'Stop'

$PackageName = 'ChocolateyGUI'
$Url = 'https://github.com/chocolatey/ChocolateyGUI/releases/download/1.0.0/ChocolateyGUI.msi'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$TmpLocation = Join-Path $InstallationPath 'tmp'
$MsiLocation = Join-Path $ToolsPath $([IO.Path]::GetFileName($Url))

$PackageArgs = @{
  PackageName  = $PackageName
  Url          = $Url
  FileFullPath = $MsiLocation
}
Get-ChocolateyWebFile @PackageArgs

New-Item -ItemType Directory -Force -Path $TmpLocation -ErrorAction Ignore | Out-Null
$MsiLocation = (Get-Item -Path $MsiLocation).FullName
$MsiArgs = "/A `"${MsiLocation}`" TARGETDIR=`"${TmpLocation}`" /QN /L*V `"$env:TEMP\$env:ChocolateyPackageName.$env:ChocolateyPackageVersion.log`""
$PackageArgs = @{
  Statements = $MsiArgs
  ExeToRun   = 'msiexec.exe'
}
Start-ChocolateyProcess @PackageArgs

$UnzipPath = (Get-ChildItem $TmpLocation -Directory | Where-Object Name -Match "Chocolatey GUI" | Select-Object -First 1).FullName
Copy-Item -Path $(Join-Path $UnzipPath "*") -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $TmpLocation -Recurse -Force -ErrorAction Ignore

$BinName = 'ChocolateyGui'
$BinPath = Join-Path $InstallationPath "${BinName}.exe"
Install-BinFile -Name $BinName -Path $BinPath -UseStart

$BinName = 'ChocolateyGuiCli'
$BinPath = Join-Path $InstallationPath "${BinName}.exe"
Install-BinFile -Name $BinName -Path $BinPath
