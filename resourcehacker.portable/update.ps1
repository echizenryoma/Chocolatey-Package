Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "http://www.angusj.com/resourcehacker"
    $version = ($page.Content -split "\n|<|>" -match "^Version\s+\d+(\.\d+)+$" | Select-Object -First 1).Replace("Version", "").Trim()

    return @{
        Version = $version;
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
