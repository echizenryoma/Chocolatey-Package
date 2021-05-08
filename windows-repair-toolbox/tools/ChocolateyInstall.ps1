$ErrorActionPreference = 'Stop'

$PackageName = 'windows-repair-toolbox'
$Url = 'https://windows-repair-toolbox.com/files/Windows_Repair_Toolbox.zip'
$Checksum = '263DED11699891B4B4B2A37CC9A4AE39631A4A110DECE276181B73C1D20C03D1'
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
