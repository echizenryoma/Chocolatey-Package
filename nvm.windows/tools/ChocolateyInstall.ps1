
$ErrorActionPreference = "Stop"

$PackageName = 'nvm'
$Url = 'https://github.com/coreybutler/nvm-windows/releases/download/1.1.9/nvm-noinstall.zip'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Join-Path $InstallationPath 'tmp'
$PackageArgs = @{
  PackageName   = $PackageName
  Url           = $Url
  UnzipLocation = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$UnzipPath = (Get-Item $UnzipLocation).FullName
Copy-Item -Path $(Join-Path $UnzipPath '*') -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore
$RemoveFileNames = @('elevate.cmd', 'elevate.vbs', 'install.cmd')
foreach ($RemoveFileName in $RemoveFileNames) {
  $RemoveFile = Join-Path $InstallationPath $RemoveFileName
  Remove-Item -Path $RemoveFile -Recurse -Force -ErrorAction Ignore
}

$NodePath = Join-Path $InstallationPath 'node'
$OsBits = Get-ProcessorBits
$NvmSettingsFile = Join-Path $InstallationPath "settings.txt"

$NvmSettingsDict = [ordered]@{}
if (Test-Path $NvmSettingsFile) {
  $NvmSettings = Get-Content $NvmSettingsFile
  $NvmSettings | Foreach-Object { $NvmSettingsDict.add($_.split(':', 2)[0], $_.split(':', 2)[1]) }
  Write-Output "Detected existing settings file"
  $NvmSettingsDict.GetEnumerator() | ForEach-Object { "$($_.Name): $($_.Value)" } | Write-Verbose
}

if (!($NvmSettingsDict['root'])) { $NvmSettingsDict['root'] = $InstallationPath }
if (!($NvmSettingsDict['path'])) { $NvmSettingsDict['path'] = $NodePath }
if (!($NvmSettingsDict['arch'])) { $NvmSettingsDict['arch'] = $OsBits }
if (!($NvmSettingsDict['proxy'])) { $NvmSettingsDict['proxy'] = "none" }

$NvmSettingsDict.GetEnumerator() | ForEach-Object { "$($_.Name): $($_.Value)" } | Write-Verbose
$NvmSettingsDict.GetEnumerator() | ForEach-Object { "$($_.Name): $($_.Value)" } | Out-File $NvmSettingsFile -Force -Encoding ascii

Install-ChocolateyEnvironmentVariable -VariableName "NVM_HOME" -VariableValue $InstallationPath -VariableType Machine
Install-ChocolateyEnvironmentVariable -VariableName "NVM_SYMLINK" -VariableValue $NodePath -VariableType Machine

Install-ChocolateyPath -PathToInstall $NodePath -PathType Machine

$BinFile = Get-Item $(Join-Path $InstallationPath "${PackageName}.exe")
Install-BinFile -Path $BinFile -Name "${PackageName}"
