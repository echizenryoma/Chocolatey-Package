﻿$PackageName = 'BeyondCompare'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore

Uninstall-BinFile -Name 'BCompare'