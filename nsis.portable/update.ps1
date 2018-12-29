Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://sourceforge.net/projects/nsis/files/"
    $version = ($page.Links.title -match "\d+(\.\d+)+") -split "/|\:|\s|-" -match "\d+(\.\d+)+" | Select-Object -Unique -First 1
    $url = "https://sourceforge.net/projects/nsis/files/NSIS%20$(([version]$version).Major)/${version}/nsis-${version}.zip"
	
    return @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
