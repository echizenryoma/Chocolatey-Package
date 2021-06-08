$VBoxName = 'Oracle VM VirtualBox Extension Pack'
$VBoxManage = Join-Path $Env:VBOX_MSI_INSTALL_PATH "VBoxManage.exe"

& $VBoxManage extpack uninstall "$VBoxName"