$ErrorActionPreference = 'Stop'

$PackageName = 'antlr4'
$Url = 'https://www.antlr.org/download/antlr-4.11.1-complete.jar'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$SavePath = Join-Path ${ToolsPath} "antlr4-complete.jar"

$PackageArgs = @{
    PackageName  = $PackageName
    Url          = $Url
    FileFullPath = $SavePath
}
Get-ChocolateyWebFile @PackageArgs
