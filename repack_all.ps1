WorkFlow Choco-Pack {
    $dirs = Get-ChildItem -Directory -Exclude ".git"
    foreach -parallel ($dir in $dirs) {
        $nuspec = Get-ChildItem -File $(Join-Path $dir "*.nuspec")
        if (($nuspec | Measure-Object).Count -ge 1) {
            [xml]$XmlDocument = Get-Content -Path $nuspec
            $id = $XmlDocument.package.metadata.id
            $version = $XmlDocument.package.metadata.version

            $nupkg = Join-Path $dir "$id.$version.nupkg"
            if (-Not (Test-Path $nupkg)) {
                $null = choco pack $(Join-Path $dir "$($dir.Name).nuspec") --out "$dir"
            }
        }
    }
}

Push-Location $PSScriptRoot
git pull
Choco-Pack