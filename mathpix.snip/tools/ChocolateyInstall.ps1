$ErrorActionPreference = 'Stop'

$PackageName = 'mathpix.snip'
$Url = 'https://mathpix.com/win_app/mathpix_snipping_tool_setup.exe'
$Checksum = '093505F84D7F176EAB7C7AC6A8EA6533F0D74D3751F2969A28F1BB943EA8F1D5'
$ChecksumType = 'sha256'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$FileName = [IO.Path]::GetFileName($Url)
$BinPath = Join-Path $ToolsPath $FileName
$PackageArgs = @{
    PackageName  = $PackageName
    Url          = $Url
    Checksum     = $Checksum 
    ChecksumType = $ChecksumType
    FileFullPath = $BinPath
}
Get-ChocolateyWebFile @PackageArgs

& innounp.exe -x -d"$ToolsPath" -y "$BinPath"

Remove-Item -Path $BinPath -Force
Rename-Item -Path $(Join-Path $ToolsPath '{app}') -NewName 'app' -Force

Get-ChildItem $ToolsPath -File -Filter "*.exe" -Exclude "*mathpix*" -Recurse | ForEach-Object { $null = New-Item "$($_.FullName).ignore" -Type File -Force }
