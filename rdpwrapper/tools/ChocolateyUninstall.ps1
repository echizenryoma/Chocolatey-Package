$ToolsPath = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)
Start-ChocolateyProcessAsAdmin '-u' (Join-Path $ToolsPath 'RDPWInst.exe')
