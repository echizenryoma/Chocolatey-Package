﻿$PackageName = 'maxima'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore
