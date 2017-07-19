$ErrorActionPreference = 'Stop'

$PackageName = 'ultraiso'
$Url = 'http://dw.ezbsystems.com/uiso9_cn.exe'

$PackageArgs = @{
    PackageName = $PackageName
    Url         = $Url
    SilentArgs  = '/SILENT /TASKS="desktopicon,fileassoc"'
}
Install-ChocolateyPackage @PackageArgs

$reg = "HKCU:\SOFTWARE\EasyBoot Systems\UltraISO\5.0"
if (!(Test-Path $reg)) {
    New-Item -Path $reg -Force
}
Set-ItemProperty -Path $reg -Name "UserName" -Value "王涛" -Force
Set-ItemProperty -Path $reg -Name "Registration" -Value "69414b170e136f766a32471009176109" -Force
