$ErrorActionPreference = 'Stop'

$PackageName = 'windows-repair-toolbox'
$Url = 'https://windows-repair-toolbox.com/files/Windows_Repair_Toolbox.zip'
$Checksum = '932324AC8A51225D5BFA739F94E9B56CCFFFE6F6CFF876DD4063B409E19DDF92'
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
