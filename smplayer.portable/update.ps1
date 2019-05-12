Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $base = "https://sourceforge.net/projects/smplayer/files/SMPlayer"
    $url = $base
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $version = ($page.Links.title -match "\d+(\.\d+)+$") -split "\s" -match "\d+(\.\d+)+$" | Select-Object -Unique -First 1
    $url = "${base}/${version}"

    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $url32 = (($page.Links.href -match "smplayer-portable.*7z.*download") -notmatch "64") | Select-Object -First 1
    $url64 = ($page.Links.href -match "smplayer-portable.*x64\.7z.*download") | Select-Object -First 1
	
    return @{
        Version = $version
        URL32   = $url32
        URL64   = $url64
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
