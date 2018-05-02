$ErrorActionPreference = 'Stop'

$PackageName = 'windows-repair-toolbox'
$Url = 'https://windows-repair-toolbox.com/files/Windows_Repair_Toolbox.zip'
$Checksum = '1C1A4E52CFA42E70CF8DBB2D8390EAD21A34D2ECAADD5939C90B826C92BA1E1C'
$ChecksumType = 'SHA256'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    Checksum      = $Checksum 
    ChecksumType  = $ChecksumType
    UnzipLocation = $InstallationPath
    Options       = @{Headers = @{"referer" = "https://windows-repair-toolbox.com/?smd_process_download=1&download_id=200"}}
}
Install-ChocolateyZipPackage @PackageArgs

Install-BinFile -Name 'Windows_Repair_Toolbox' -Path $(Join-Path $InstallationPath "Windows_Repair_Toolbox.exe")
