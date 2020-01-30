$ErrorActionPreference = 'Stop'

$PackageName = 'mathpix.snip'
$Url = 'https://mathpix.com/win_app/mathpix_snipping_tool_setup.exe'
$Checksum = '613769739372B96E8424C3BF7C3CED5FF4B393C0DFC8136B5438DA83AAD50A54'
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

& innoextract.exe -e "$BinPath" -d "$ToolsPath"

Remove-Item -Path $BinPath -Force

Get-ChildItem $ToolsPath -File -Filter "*.exe" -Exclude "*mathpix*" -Recurse | ForEach-Object { $null = New-Item "$($_.FullName).ignore" -Type File -Force }
