import-module au

function global:au_SearchReplace {
    @{
        ".\tools\ChocolateyInstall.ps1" = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $base = 'https://files.gpg4win.org/'
    $page = Invoke-WebRequest -UseBasicParsing -Uri $base
    $file = $page.Links.href -match "gpg4win-light-\d+(\.\d+)+\.exe$" | Select-Object -Last 1
    $version = $file -split "-|\.exe" -match "\d+(\.\d+)+" | Select-Object -First 1
    $url = $base + $file

    @{
        Version = $version
        URL32   = $url
    }
}

update -ChecksumFor none
