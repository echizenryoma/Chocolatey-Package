Import-Module AU

function global:au_SearchReplace {
    @{
        "tools\ChocolateyInstall.ps1" = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL)'"
        }
    }
}
function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://www.npcglib.org/~stathis/blog/precompiled-openssl/" 
    $url32 = 'https://www.npcglib.org' + ($page.Links | Where-Object href -Match 'openssl-\d+(\.\d+){1,}[a-z]-vs2017\.7z' | Select-Object -First 1 -ExpandProperty href)

    $version32 = $url32 -split "-" -match "^\d+(\.\d+){1,}[a-z]" | Select-Object -First 1
    $rev = [char]$version32[$version32.Length - 1] - [char]'a' + 1
    $version32 = $version32 -replace '[a-z]+$', ".$rev"

    return @{
        URL     = $url32
        Version = $version32
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
