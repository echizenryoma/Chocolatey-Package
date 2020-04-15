$ErrorActionPreference = 'Stop'

$PackageName = 'notepad3'
$Url = 'https://github.com/rizonesoft/Notepad3/releases/download/RELEASE_5.20.414.1/Notepad3_5.20.414.1.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
   PackageName   = $PackageName
   Url           = $Url
   UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs


$Url32 = (Get-ChildItem -Path $ToolsPath | Where-Object Name -Match "x86.zip" | Select-Object -Last 1).FullName
$Url64 = (Get-ChildItem -Path $ToolsPath | Where-Object Name -Match "x64.zip" | Select-Object -Last 1).FullName

$PackageArgs = @{
   PackageName   = $PackageName
   Url           = $Url32
   Url64         = $Url64
   UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

Remove-Item -Path $(Join-Path $ToolsPath "*.zip") -WarningAction Ignore
