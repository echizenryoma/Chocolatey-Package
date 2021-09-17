$ErrorActionPreference = 'Stop'

$PackageName = 'windows-repair-toolbox'
$Url = 'https://windows-repair-toolbox.com/files/Windows_Repair_Toolbox.zip'
$Checksum = 'B1473D8E07B5E2E23B4081BF1C85F3D30173B63951DEEDF77FCFC90E02512D32'
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
