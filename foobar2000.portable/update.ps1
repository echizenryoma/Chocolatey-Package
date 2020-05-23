Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $base = "https://www.foobar2000.org"
    $page = Invoke-WebRequest -UseBasicParsing -Uri "$base/download"

    $url = $base + ($page.Links.href -match "\.exe$" | Select-Object -Unique -First 1)
    $version = $url -split "v|_|\.exe" -match "\d+(\.\d+)+" | Select-Object -Unique -Last 1
	
    return @{
        Version = $version
        URL32   = $url.Replace("/getfile/", "/files/")
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
