Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://www.virtualbox.org/wiki/Downloads"
    $url = $page.Links.href -match ".vbox-extpack"
    $version = (($url -split "/" -match ".vbox-extpack")[0] -split '-|\.vbox-extpack' -match "\d+(\.\d+)*")

    return @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
