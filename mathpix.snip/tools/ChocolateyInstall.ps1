$ErrorActionPreference = 'Stop'

$PackageName = 'mathpix.snip'
$Url = 'https://mathpix.com/win_app/mathpix_snipping_tool_setup.exe'
$Checksum = '0FECC7AA72FB6903C5ED480F058FB228EC88992B545E08EB4EFF9E699028FD9E'
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
