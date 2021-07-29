$ErrorActionPreference = 'Ignore'

$PackageName = 'VirtualBox.ExtensionPack'
$Url = 'https://download.virtualbox.org/virtualbox/6.1.26/Oracle_VM_VirtualBox_Extension_Pack-6.1.26.vbox-extpack'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$VBoxExtensionPack = Join-Path $ToolsPath $([IO.Path]::GetFileName($Url))
$VBoxManage = Join-Path $Env:VBOX_MSI_INSTALL_PATH "VBoxManage.exe"

# Refresh the PS session environment so that if VirtualBox was just installed in this session, it will be found in PATH
Update-SessionEnvironment

$PackageArgs = @{
  PackageName  = $PackageName
  Url          = $Url
  FileFullPath = $VBoxExtensionPack
}
Get-ChocolateyWebFile @PackageArgs



# Install the Extension Pack using VBoxManage
Write-Output "y" | & "$VBoxManage" extpack install --replace "$VBoxExtensionPack" 2>1
