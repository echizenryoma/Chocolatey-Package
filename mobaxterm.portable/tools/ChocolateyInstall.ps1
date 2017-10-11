$ErrorActionPreference = 'Stop';

$PackageName = 'mobaxterm'
$Url = 'https://download.mobatek.net/10420170816103227/MobaXterm_Portable_v10.4.zip'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    url           = $Url
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs
Install-ChocolateyShortcut -ShortcutFilePath "$Env:SystemDrive\Users\Public\Desktop\MobaXTerm.lnk" -TargetPath $(Join-Path $InstallationPath ([IO.Path]::GetFileName($Url)).Replace("zip", "exe")) 