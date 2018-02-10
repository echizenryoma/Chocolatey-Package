Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]Checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]ChecksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    $request = Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/SubtitleEdit/subtitleedit/releases/latest" -MaximumRedirection 0 -ErrorAction Ignore
    $url = $request.Headers.Location
    $version = $url -Split "/" | Select-Object -Last 1
    $url = "https://github.com/SubtitleEdit/subtitleedit/releases/download/$version/SE$($version.Replace(".", '')).zip"
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/SubtitleEdit/subtitleedit/releases/tag/$version"
    $checksum = $page.Content -split "<|>|\n" -match "^[0-9a-f]{64}$" | Select-Object -First 1 -Skip 1
	
    return @{
        Version        = $version
        URL32          = $url
        Checksum32     = $checksum
        ChecksumType32 = 'SHA256'
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
