Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "http://nsis.sourceforge.net/Download"
    $url = ($page.Links | Where-Object href -Match "\d+(\.\d+)+").href | Select-Object -Unique -First 1
    $version = $url -Split "/|-" -Match "\d+(\.\d+)+" | Select-Object -First 1
    $url = "https://sourceforge.net/projects/nsis/files/NSIS%20$(([version]$version).Major)/${version}/nsis-${version}.zip"
	
    return @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
