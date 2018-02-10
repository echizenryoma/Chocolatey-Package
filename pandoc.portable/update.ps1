Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1'   = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}https://github.com/jgm/pandoc/releases/tag/$($Latest.Version)`$2"
        }
    }
}

function global:au_GetLatest {
    $request = Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/jgm/pandoc/releases/latest" -MaximumRedirection 0 -ErrorAction Ignore
    $url = $request.Headers.Location
    $version = $url -Split "/" | Select-Object -Last 1
    $url = "https://github.com/jgm/pandoc/releases/download/${version}/pandoc-${version}-windows.zip"   
	
    return @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
