Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $request = Invoke-WebRequest -Uri "https://github.com/stascorp/rdpwrap/releases/latest" -MaximumRedirection 0 -ErrorAction Ignore
    $url =  $request.Headers.Location
    $version = $url -Split "/" | Select-Object -Last 1
    $version = $version.Replace("v", "").Trim()
	
    return @{
        Version = $version;
        URL32 = "https://github.com/stascorp/rdpwrap/releases/download/v${version}/RDPWrap-v${version}.zip";
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
