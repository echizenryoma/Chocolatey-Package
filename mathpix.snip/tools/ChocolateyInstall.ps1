$ErrorActionPreference = 'Stop'

$PackageName = 'mathpix.snip'
$Url = 'https://mathpix.com/win_app/mathpix_snipping_tool_setup.exe'
$Checksum = '1DBB7E64ABBEC740621987F9579DF0792D41CE9A08E4E2E63E6F37538AE87715'
$ChecksumType = 'sha256'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

Remove-Item -Path $(Join-Path $ToolsPath 'app') -Recurse -Force -ErrorAction Ignore

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
