$ErrorActionPreference = 'Stop'

$PackageName = 'windows-repair-toolbox'
$Url = 'https://windows-repair-toolbox.com/files/Windows_Repair_Toolbox.zip'
$Checksum = '74AC635218B19EC6C31FD5076FEF2B27F0E8890A65095AF3AD10E8E85D4DF1FF'
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
