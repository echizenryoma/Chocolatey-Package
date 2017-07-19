$pPackageName= 'rdpwrapper'
$toolsDir = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)

Start-ChocolateyProcessAsAdmin '-u' (Join-Path $toolsDir 'RDPWInst.exe')
