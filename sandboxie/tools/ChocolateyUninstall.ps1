$ErrorActionPreference = 'Stop'

Remove-Item -Force -Recurse "Registry::HKEY_CLASSES_ROOT\CLSID\{98E6BD24-2D93-41A5-BC6D-CB7C1507318B}" -ErrorAction Ignore
