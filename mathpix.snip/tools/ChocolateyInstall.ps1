$ErrorActionPreference = 'Stop'

$PackageName = 'mathpix.snip'
$Url = 'https://download.mathpix.com/windows/mathpix_snipping_tool_setup.latest.exe'
$Checksum = 'DA34521A7C63B4AB9EAC9F5F2FE76E17D25AFA3B51B9C579EBE089F3878C838D'
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
