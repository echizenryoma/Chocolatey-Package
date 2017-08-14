$ErrorActionPreference = 'Stop'

$PackageName = 'openssl'
$Url =  'https://www.npcglib.org/~stathis/downloads/openssl-1.1.0f-vs2017.7z'
$installationPath = Get-ToolsLocation

$OpenSSL_HOME = Join-Path $installationPath $PackageName
if (Test-Path $OpenSSL_HOME) {
    Remove-Item -Path $OpenSSL_HOME -Recurse -Force
}

$PackageArgs = @{
    PackageName   = $PackageName
    url           = $url
    UnzipLocation = $installationPath
}
Install-ChocolateyZipPackage @PackageArgs

$fileName = [IO.Path]::GetFileNameWithoutExtension($url)
Rename-Item $(Join-Path $installationPath $fileName) -NewName $OpenSSL_HOME

$envPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine) -split ';' -notmatch 'openssl'
[Environment]::SetEnvironmentVariable('Path', $envPath -join ';', [EnvironmentVariableTarget]::Machine)

if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne $True) {
    $OpenSSL_BIN = Join-Path $OpenSSL_HOME "bin64"
}
else {
    $OpenSSL_BIN = Join-Path $OpenSSL_HOME "bin"
}
Install-ChocolateyPath -PathToInstall $OpenSSL_BIN -PathType 'Machine'

Install-ChocolateyEnvironmentVariable -VariableName 'OPENSSL_ROOT_DIR' -VariableValue $OpenSSL_HOME -VariableType 'Machine'

$lib64 = Join-Path $OpenSSL_HOME 'lib64'
if (Test-Path $lib64) {
    $lib = Join-Path $OpenSSL_HOME 'lib'
    $files = Get-ChildItem -File -Path $lib -Include "*M*"
    foreach ($file in $files) {
        $new = $file.Name.Replace("M", "32M")
        Rename-Item -Path $file.FullName -NewName $new
    }
	$files = Get-ChildItem -File -Path $lib -Include "*.pdb"
	foreach ($file in $files) {
        $new = $file.Name.Replace(".pdb", "32.pdb")
        Rename-Item -Path $file.FullName -NewName $new
    }

    $files = Get-ChildItem -File -Path $lib64 -Include "*M*"
    foreach ($file in $files) {
        $new = $file.Name.Replace("M", "64M")
        Rename-Item -Path $file.FullName -NewName $new
    }
	$files = Get-ChildItem -File -Path $lib64 -Include "*.pdb"
	foreach ($file in $files) {
        $new = $file.Name.Replace(".pdb", "64.pdb")
        Rename-Item -Path $file.FullName -NewName $new
    }
    Move-Item -Path $(Join-Path $lib64 "*") -Destination $lib -Force
    Remove-Item -Path $lib64 -Recurse -Force
}
