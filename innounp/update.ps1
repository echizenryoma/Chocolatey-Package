Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $base = "https://sourceforge.net/projects/innounp/files/innounp"
    $page = Invoke-WebRequest -UseBasicParsing -Uri $base
    $version = ($page.Links.title -match "\d+(\.\d+)+$") -split "\s" -match "\d+(\.\d+)+$" | Select-Object -Unique -First 1
    $url = "$base/innounp%20${version}/innounp$($version -replace "\.", '').rar"
	
    return @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
