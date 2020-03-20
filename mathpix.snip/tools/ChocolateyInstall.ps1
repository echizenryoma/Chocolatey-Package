$ErrorActionPreference = 'Stop'

$PackageName = 'mathpix.snip'
$Url = 'https://mathpix.com/win_app/mathpix_snipping_tool_setup.exe'
$Checksum = '8AC8C6E2373FFC006D53ADBBF949925CB3E8DDB9D6917ADFAABB6A268162C565'
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
