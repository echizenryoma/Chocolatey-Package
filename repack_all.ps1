WorkFlow Choco-Pack {
    $dirs = Get-ChildItem -Directory -Exclude ".git" -Recurse
    foreach -parallel ($dir in $dirs) {
        $nuspec = Get-ChildItem -File $(Join-Path $dir "*.nuspec")
        if (($nuspec | Measure-Object).Count -ge 1) {
            $null = choco pack $(Join-Path $dir "$($dir.Name).nuspec") --out "$dir"
        }       
    }
}

Push-Location $PSScriptRoot
git pull
Remove-Item * -Include "*.nupkg" -Recurse -Force
Choco-Pack