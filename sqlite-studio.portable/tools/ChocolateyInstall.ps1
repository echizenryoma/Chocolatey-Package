$ErrorActionPreference = 'Stop'

$PackageName = 'sqlite-studio.portable'
$Url = 'https://sqlitestudio.pl/files/sqlitestudio3/complete/win32/sqlitestudio-3.1.1.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    Checksum      = $Checksum
    ChecksumType  = $ChecksumType
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
Get-ChildItem $ToolsPath -Include "*.exe" -Exclude "SQLiteStudio.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
