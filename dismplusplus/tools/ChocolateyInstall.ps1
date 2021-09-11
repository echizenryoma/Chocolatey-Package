$ErrorActionPreference = 'Stop'

$PackageName = 'dism++'
$Url = 'http://gh.api.99988866.xyz/github.com/Chuyu-Team/Dism-Multi-language/releases/download/v10.1.1002.1/Dism++10.1.1002.1.zip'
$Checksum = 'bd782ba834a77661db0b272c00afd5377404b23cb26783507ded145f4c72f9a6'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = $InstallationPath
$Architecture = $(Get-WmiObject Win32_Processor).AddressWidth

if (Test-Path $InstallationPath) {
  Get-ChildItem -Path $InstallationPath -exclude 'opt' | Remove-Item -Recurse -Force -ErrorAction Ignore
}

$PackageArgs = @{
  PackageName   = $PackageName
  Url           = $Url
  ChecksumType  = 'sha256'
  Checksum      = $Checksum
  UnzipLocation = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$BinPath = (Get-ChildItem $UnzipLocation -File | Where-Object Name -Match "Dism\+\+x${Architecture}" | Select-Object -First 1).FullName
Install-BinFile -Name "${PackageName}" -Path $BinPath
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "Dism++.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinPath -WorkingDirectory $InstallationPath
