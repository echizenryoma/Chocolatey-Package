Function Choco-Pack {
    $dirs = Get-ChildItem -Directory -Exclude ".git"
    foreach ($dir in $dirs) {
        $nuspec = Join-Path $dir "$($dir.Name).nuspec"
        if (Test-Path $nuspec) {
            [xml]$XmlDocument = Get-Content -Path $nuspec
            $version = $XmlDocument.package.metadata.version
            $nupkg = Join-Path $dir "$($dir.Name).$version.nupkg"
            if (-not (Test-Path $nupkg)) {
                $null = choco pack "$(Join-Path $dir "$($dir.Name).nuspec")" --out "$dir"
            }
        }
    }
}

Push-Location $PSScriptRoot
#Remove-Item * -Include *.nupkg -Recurse -Force
git pull
Choco-Pack