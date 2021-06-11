$ErrorActionPreference = 'Stop'

$PackageName = 'mathpix.snip'
$Url = 'https://download.mathpix.com/windows/mathpix_snipping_tool_setup.latest.exe'
$Checksum = 'D900244FD313BA6F24CC56CD524E9ACCFED510F527C0EA398A34A9FA76E94485'
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
