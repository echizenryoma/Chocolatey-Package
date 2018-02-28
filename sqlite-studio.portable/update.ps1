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
    $base = "https://sqlitestudio.pl/files/sqlitestudio3/complete/win32"

    $page = Invoke-WebRequest -UseBasicParsing -Uri "${base}/?C=N;O=D"
    $url = $base + ($page.Links.href -Match "sqlitestudio-\d+(\.\d+)+.zip" | Select-Object -First 1)
    $version = $([IO.Path]::GetFileNameWithoutExtension($url)) -split "-" -match "\d+(\.\d+)+" | Select-Object -First 1

    return @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
