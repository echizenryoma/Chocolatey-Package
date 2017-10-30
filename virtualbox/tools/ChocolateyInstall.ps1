$ErrorActionPreference = 'Stop'

$PackageName = 'virtualbox'
$Url32 = 'http://download.virtualbox.org/virtualbox/5.2.0/VirtualBox-5.2.0-118431-Win.exe'
$Checksum32 = '9d6716fe24d352b91fe682044668fac90c92ecabbe56821631069f88024f48cd'
$ChecksumType32 = 'SHA256'
$Url64 = 'http://download.virtualbox.org/virtualbox/5.2.0/VirtualBox-5.2.0-118431-Win.exe'
$Checksum64 = '9d6716fe24d352b91fe682044668fac90c92ecabbe56821631069f88024f48cd'
$ChecksumType64 = 'SHA256'
$UrlExtra = 'http://download.virtualbox.org/virtualbox/5.2.0/Oracle_VM_VirtualBox_Extension_Pack-5.2.0.vbox-extpack'
$ChecksumExtra = '005ba9211862643e2516d549e98b80942918047f1f6c55fcfe08c490dd1947bc'
$ChecksumTypeExtra = 'SHA256'

#https://www.virtualbox.org/manual/ch02.html#idm819
$PackageParameters = Get-PackageParameters
$SilentArgs = @('-s -l -msiparams REBOOT=ReallySuppress')
$SilentArgs += if (!$PackageParameters.CurrentUser) { 'ALLUSERS=1' } else { 'ALLUSERS=2'; Write-Host 'Param: Installing for current user' }
$SilentArgs += if ($PackageParameters.NoDesktopShortcut) { 'VBOX_INSTALLDESKTOPSHORTCUT=0'; Write-Host 'Param: No desktop shortcut' }
$SilentArgs += if ($PackageParameters.NoQuickLaunch) { 'VBOX_INSTALLQUICKLAUNCHSHORTCUT=0'; Write-Host 'Param: No quick launch shortcut' }
$SilentArgs += if ($PackageParameters.NoRegister) { 'VBOX_REGISTERFILEEXTENSIONS=0'; Write-Host 'Param: No registration for virtualbox file extensions' }

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $Url32
    Checksum       = $Checksum32
    ChecksumType   = $ChecksumType32
    Url64          = $Url64
    Checksum64     = $Checksum64
    ChecksumType64 = $ChecksumType64
    SilentArgs     = $SilentArgs
}
Install-ChocolateyPackage @PackageArgs

$InstallLocation = $env:VBOX_MSI_INSTALL_PATH
if (!$InstallLocation) { Write-Warning "Can't find $packageName install location, can't install extension pack"; return }

if (!$PackageParameters.NoExtensionPack) {
    Write-Host "Installing extension pack"

    $ExtraFile = $(Join-Path $(Get-PackageCacheLocation) [IO.Path]::GetFileName($UrlExtra))
    $ExtraPackageArgs = @{
        PackageName    = 'virtualbox-extensionpack'
        Url            = $UrlExtra
        Checksum       = $ChecksumExtra
        ChecksumType   = $ChecksumTypeExtra
        Url64          = $UrlExtra
        Checksum64     = $ChecksumExtra
        ChecksumType64 = $ChecksumTypeExtra
        FileFullPath   = $(Join-Path $(Get-PackageCacheLocation) [IO.Path]::GetFileName($UrlExtra))
    }
    Get-ChocolateyWebFile $ExtraPackageArgs
    if (!(Test-Path $ExtraFile)) {
        Write-Warning "Can't download latest extension pack" 
    }
    else {
        Set-Alias vboxmanage $InstallLocation\VBoxManage.exe
        "y" | vboxmanage extpack install --replace $ExtraFile
        if ($LastExitCode -ne 0) {
            Write-Warning "Extension pack installation failed with exit code $LastExitCode" 
        }
    }
}

if (!$PackageParameters.NoPath) {
    Write-Host "Adding to PATH if needed"
    Install-ChocolateyPath $InstallLocation
}
