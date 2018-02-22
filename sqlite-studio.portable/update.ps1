Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_AfterUpdate ($Package)  {
    $global:Options.Push = $true
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://sqlitestudio.pl/files/sqlitestudio3/complete/win32/?C=N;O=D"
    $zip = $page.Links | Where-Object href -Match "sqlitestudio-\d+(\.\d+){0,2}.zip" | Select-Object -First 1 -ExpandProperty href
    $version = $zip.Substring($zip.LastIndexOf("-") + 1).Replace(".zip", "").Trim()
    $url = "https://sqlitestudio.pl/files/sqlitestudio3/complete/win32/$zip"

    return @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
