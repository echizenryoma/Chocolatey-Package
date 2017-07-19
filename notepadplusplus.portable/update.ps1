Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]Checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]ChecksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
            "(^[$]UrlExtra\s*=\s*)('.*')"     = "`${1}'$($Latest.URL_EXTRA)'"
        }
    }
}

function global:au_GetLatest {
    $url = "https://notepad-plus-plus.org/download/"
    $request = Invoke-WebRequest -Uri $url -MaximumRedirection 0 -ErrorAction Ignore
    
    $url = $request.Headers.Location
    $version = $url -Split "/" | Select-Object -Last 1
    $version = $version.Replace("v", "").Replace(".html", "").Trim()
    
    $base = "https://notepad-plus-plus.org/repository/$($version.Substring(0, $version.IndexOf("."))).x/$version"
    
    $page = Invoke-WebRequest -UseBasicParsing -Uri "$base\npp.$version.sha1.md5.digest.txt"
    $page = $page.Content -Split '\n'
    $obj = $page -like "*.bin.7z" | Select-Object -First 1 | ConvertFrom-String -PropertyNames sha1sum, filename
    $sha1sum = $obj.sha1sum

    return @{
        Version        = $version
        URL32          = "$base/npp.$version.bin.7z"
        ChecksumType32 = 'sha1'
        Checksum32     = $sha1sum
        URL_EXTRA      = "$base/npp.$version.Installer.exe"
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
