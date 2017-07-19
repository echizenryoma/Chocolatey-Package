Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $request = Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/opencv/opencv/releases/latest" -MaximumRedirection 0 -ErrorAction Ignore
    $url = $request.Headers.Location
    $version = $url -Split "/" | Select-Object -Last 1
    
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/opencv/opencv/releases/latest"
    $url64 = "https://github.com" + ($page.Links | Where-Object href -Match "opencv-\d+(\.\d)+-vc\d+\.exe" | Select-Object -First 1 -ExpandProperty href)
	
    return @{
        Version = $version
        URL64   = $url64
    }
}
Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
