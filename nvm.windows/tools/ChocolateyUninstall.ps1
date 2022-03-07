$PackageName = 'nvm'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$NodePath = Join-Path $InstallationPath 'node'

Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore

Uninstall-ChocolateyEnvironmentVariable -VariableName 'NVM_HOME' -VariableType Machine
Uninstall-ChocolateyEnvironmentVariable -VariableName 'NVM_SYMLINK' -VariableType Machine

$RemovePaths = @(
    $InstallationPath,
    $NodePath
)

$EnvPath = Get-EnvironmentVariable -Name 'PATH' -Scope Machine -PreserveVariables
[string[]]$NewPath = ''
foreach ($Path in $EnvPath.split(';')) {
    if (($Path) -and ($Path -notin $RemovePaths)) {
        $NewPath += $Path
    }
    else {
        Write-Output "Path to remove found: $Path"
    }
}
$AssembledNewPath = ($NewPath -join(';')).trimend(';')
Install-ChocolateyEnvironmentVariable -VariableName 'PATH' -VariableValue $AssembledNewPath -VariableType Machine

Uninstall-BinFile -Name "${PackageName}"
