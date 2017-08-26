$ErrorActionPreference = 'Stop';

$PackageName = 'golang'
$InstallationPath = Get-ToolsLocation

$GOROOT = Join-Path $InstallationPath 'go'
Get-ChildItem -Path  $GOROOT -Recurse -exclude somefile.txt |
Select-Object -ExpandProperty FullName |
Where-Object {$_ -notmatch 'opt'} |
Remove-Item -Force | Out-Null 
