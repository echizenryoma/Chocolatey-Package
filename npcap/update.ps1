Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $base = "https://nmap.org/npcap/"
    $page = Invoke-WebRequest -UseBasicParsing -Uri "${base}"
    $url32 = $base + ($page.Links.href -match ".exe$")[0]
    $version = ($url32 -split "/|-|.exe" -match "\d+(\.\d+)+")[0]

    return @{
        Version = $version
        URL32   = $url32
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none