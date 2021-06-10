$ErrorActionPreference = 'Stop'

$PackageName = 'mathpix.snip'
$Url = 'https://download.mathpix.com/windows/mathpix_snipping_tool_setup.latest.exe'
$Checksum = '3529B0758E0736113D01C46FF028D7E2B138780D1EC44CCFC655F3D5B09D73CD'
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
