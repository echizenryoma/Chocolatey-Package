Import-Module AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -Uri 'http://www.python.org/downloads/'
    $url = $page.Links | Where-Object href -match 'python-(2.+)\.msi$' | Select-Object -First 1 -ExpandProperty href
    $version = $Matches[1]

    return @{
        Version = $version
        URL32   = $url
        URL64   = $url.Replace('.msi', '.amd64.msi')
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
