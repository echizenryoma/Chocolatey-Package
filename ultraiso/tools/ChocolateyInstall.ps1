$ErrorActionPreference = 'Stop'

$PackageName = 'ultraiso'
$Url = 'http://dw.ezbsystems.com/uiso9_cn.exe'

$PackageArgs = @{
    PackageName = $PackageName
    Url         = $Url
    SilentArgs  = '/SILENT /TASKS="desktopicon,fileassoc"'
}
Install-ChocolateyPackage @PackageArgs

$RegisterRoot = "HKCU:\SOFTWARE\EasyBoot Systems\UltraISO\5.0"
New-Item -Path $RegisterRoot -Force -ErrorAction Ignore
Set-ItemProperty -Path $RegisterRoot -Name "UserName" -Value "王涛" -Force
Set-ItemProperty -Path $RegisterRoot -Name "Registration" -Value "69414b170e136f766a32471009176109" -Force
