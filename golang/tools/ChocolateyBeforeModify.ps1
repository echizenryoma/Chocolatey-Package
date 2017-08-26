$ErrorActionPreference = 'Stop';

$PackageName = 'golang'
$InstallationPath = Get-ToolsLocation

$GOROOT = Join-Path $InstallationPath 'go'
$GOPATH = Join-Path $GOROOT 'opt'
Get-ChildItem -Path  $GOROOT -Recurse -exclude somefile.txt |
Select-Object -ExpandProperty FullName |
Where-Object {$_ -notlike $(Join-Path $GOPATH '*')} |
Remove-Item -Force | Out-Null 
