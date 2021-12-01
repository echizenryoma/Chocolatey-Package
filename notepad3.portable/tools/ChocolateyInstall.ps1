$ErrorActionPreference = 'Stop'

$PackageName = 'notepad3'
$Url32 = 'https://github.com/rizonesoft/Notepad3/releases/download/RELEASE_5.21.1129.1/Notepad3_5.21.1129.1_x86.zip'
$Url64 = 'https://github.com/rizonesoft/Notepad3/releases/download/RELEASE_5.21.1129.1/Notepad3_5.21.1129.1_x64.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
   PackageName   = $PackageName
   Url           = $Url32
   Url64         = $Url64
   UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
