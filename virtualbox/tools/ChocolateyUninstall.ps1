$PackageParameters = Get-PackageParameters

if ($PackageParameters.KeepExtensions) {
    return
}

$InstallLocation = $env:VBOX_MSI_INSTALL_PATH
if (!$InstallLocation) { Write-Warning "Can not find existing installation location of $PackageName"; return }
$vboxManage = Join-Path $InstallLocation "VBoxManage.exe"
if (!(Test-Path $VboxManage)) { Write-Warning "Existing installation of $PackageName found but unable to find VBoxManage.exe"; return }

$extensions = . $vboxManage list extpacks | Where-Object { $_ -match 'Pack no' } | ForEach-Object { $_ -split '\:' | Select-Object -Last 1 }
$extensions | % {
    $extName = $_.Trim()
    Write-Host "Uninstalling extension: '$extName'"
    Start-ChocolateyProcessAsAdmin -ExeToRun $vboxManage -Statements 'extpack', 'uninstall', "`"$extName`"" -Elevate 2>&1
}

Write-Host "Cleaning up extensions before uninstalling virtualbox"
Start-ChocolateyProcessAsAdmin -ExeToRun $vboxManage -Statements 'extpack', 'cleanup' 2>&1

$EnvPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine) -split ';' -notmatch "$InstallLocation"
[Environment]::SetEnvironmentVariable('Path', $EnvPath -join ';', [EnvironmentVariableTarget]::Machine)