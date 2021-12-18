$ErrorActionPreference = 'Stop'

$PackageName = 'inno-setup'
$Url32 = 'https://jrsoftware.org/download.php/is.exe'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Join-Path $InstallationPath 'tmp'

$DownloadFile = Join-Path $UnzipLocation $([IO.Path]::GetFileName($Url32))
$PackageArgs = @{
    PackageName  = $PackageName
    Url          = $Url32
    FileFullPath = $DownloadFile
}
Get-ChocolateyWebFile @PackageArgs

& innoextract.exe -e "$DownloadFile" -d "$UnzipLocation"

$AppPath = (Get-ChildItem -Path $UnzipLocation -Recurse -Include "ISCC.exe").Directory.FullName
Copy-Item -Path $(Join-Path $AppPath "*") -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore

Install-BinFile -Path $(Join-Path $InstallationPath 'ISCC.exe') -Name 'ISCC'
