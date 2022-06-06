Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $base = "https://www.scootersoftware.com"
    $page = Invoke-WebRequest -UseBasicParsing -Uri "$base/download.php"
    $url64 = $base + ($page.Links.href -match "BCompare-.*.exe")[0]
    $version = ($url64 -split '-|.exe' -match '\d+(\.\d+)')[0]

    return @{
        URL64   = $url64
        Version = $version
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
