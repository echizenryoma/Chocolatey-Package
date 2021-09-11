Import-Module AU

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]Url\s*=\s*)('.*')"      = "`$1'$($Latest.URL)'"
            "(^[$]Checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -Uri 'https://www.chuyu.me/zh-Hans/' -UseBasicParsing
	
    $url = $page.links | Where-Object href -Match ".zip$" | Select-Object -First 1 -expand href
    $version = ($url -split '/' -match "\d+(\.\d+)+$")[0] -replace "v", ""
    
    return @{ 
        Version = $version
        URL     = $url
    }
}

Update-Package -NoCheckChocoVersion
