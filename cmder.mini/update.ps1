Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $request = Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/cmderdev/cmder/releases/latest" -MaximumRedirection 0 -ErrorAction Ignore
    $version = ($request.Headers.Location -split "/" -match "^v\d+(\.\d+)+").Replace("v", '').Trim()
    $url32 = "https://github.com/cmderdev/cmder/releases/download/v${version}/cmder_mini.zip"
	
    return @{
        Version = $version
        URL32   = $url32
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none