$ToolsPath = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)
$RDPWInstBin = Join-Path $ToolsPath 'RDPWInst.exe'
Start-ChocolateyProcessAsAdmin -ExeToRun $RDPWInstBin -Statements "-u"
