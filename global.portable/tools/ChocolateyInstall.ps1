$ErrorActionPreference = 'Stop'

$PackageName = 'global'
$Url32 = 'http://adoxa.altervista.org/global/dl.php?f=win32'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $Url32
    UnzipLocation  = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

$GTAGSCONF = Join-Path $ToolsPath 'share\gtags\gtags.conf'
$GTAGSLABEL = 'pygments'

Install-ChocolateyEnvironmentVariable -VariableName 'GTAGSCONF' -VariableValue $GTAGSCONF -VariableType 'Machine'
Install-ChocolateyEnvironmentVariable -VariableName 'GTAGSLABEL' -VariableValue $GTAGSLABEL -VariableType 'Machine'