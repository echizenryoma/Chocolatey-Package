$ErrorActionPreference = 'Stop'

$PackageName = 'sqlitebrowser'
$Url32 = 'https://github.com/sqlitebrowser/sqlitebrowser/releases/download/v3.10.1/DB.Browser.for.SQLite-3.10.1-win32.exe'
$Url64 = 'https://github.com/sqlitebrowser/sqlitebrowser/releases/download/v3.10.1/DB.Browser.for.SQLite-3.10.1-win64.exe'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

Remove-Item -Path $(Join-Path $ToolsPath "uninstgs.exe.nsis") -Force -ErrorAction Ignore
Remove-Item -Path $(Join-Path $ToolsPath '$PLUGINSDIR') -Recurse -Force -ErrorAction Ignore

Get-ChildItem $ToolsPath -Include "*.exe" -Exclude "DB Browser for SQLite.exe" -Recurse | ForEach-Object { $null = New-Item "$($_.FullName).ignore" -Type file -Force }
