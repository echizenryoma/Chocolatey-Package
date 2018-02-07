Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "http://cemu.info"
    $url64 = $page.Links | Where-Object name -eq "download" | Select-Object -First 1 -ExpandProperty href
    $version = $url64 -split "_|\.zip" -match "\d+(\.\d+)+"
	
    return @{
        Version = $version
        URL64   = $url64
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none