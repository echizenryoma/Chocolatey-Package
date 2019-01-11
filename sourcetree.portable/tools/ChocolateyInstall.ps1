$ErrorActionPreference = 'Stop'

$PackageName = 'sourcetree'
$Url = 'https://product-downloads.atlassian.com/software/sourcetree/windows/ga/SourcetreeEnterpriseSetup_3.0.15.msi'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
Remove-Item -Path $InstallationPath -Recurse -Force -ErrorAction Ignore

$FilePath = Join-Path $ToolsPath $([IO.Path]::GetFileName($Url))
$PackageArgs = @{
    PackageName  = $PackageName
    Url          = $Url
    FileFullPath = $FilePath
}
Get-ChocolateyWebFile @PackageArgs

$UnzipPath = Join-Path $ToolsPath "tmp"
New-Item -ItemType Directory -Path $UnzipPath -Force -ErrorAction Ignore

$InstallArgs = '/a "{0}" /qn TargetDir="{1}"' -f $FilePath, $UnzipPath
Start-ChocolateyProcessAsAdmin -ExeToRun 'msiexec' -Statements $InstallArgs
Remove-Item -Path $FilePath -Force -ErrorAction Ignore

$BinPath = Get-ChildItem -Directory -Path $ToolsPath -Recurse -Include $PackageName
Move-Item -Path $BinPath -Destination $(Get-ToolsLocation)
Remove-Item -Path $UnzipPath -Recurse -Force -ErrorAction Ignore

$BinFileName = Join-Path $InstallationPath "${PackageName}.exe"
Install-BinFile -Name $PackageName -Path $BinFileName
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "Source Tree.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinFileName -WorkingDirectory $InstallationPath
