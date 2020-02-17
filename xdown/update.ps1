Import-Module AU

function global:au_SearchReplace {
    @{
        "tools\ChocolateyInstall.ps1" = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $base = "https://xdown.org"
    $page = Invoke-WebRequest -UseBasicParsing -Uri $base
    $url32 = ($page.Links.href -match "xdown.*zip$")[0]
    $version = ($url32 -split "\.zip|-|/" -match "\d+(\.\d+)+")[0]
	
    return @{
        Version = $version
        URL32   = $url32
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
