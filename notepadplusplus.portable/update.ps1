Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]Checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]ChecksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
            "(^[$]UrlExtra\s*=\s*)('.*')"     = "`${1}'$($Latest.URL_Extra)'"
            "(^[$]ChecksumExtra\s*=\s*)('.*')"     = "`$1'$($Latest.ChecksumExtra)'"
            "(^[$]ChecksumTypeExtra\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumTypeExtra)'"
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
    
    $page = Invoke-WebRequest -UseBasicParsing -Uri "${base}\npp.${version}.sha1.md5.digest.txt"
    $checksum32 = ($page.Content -Split '\n' -like "*.bin.7z" | Select-Object -First 1 | ConvertFrom-String -PropertyNames sha1sum, filename).sha1sum
    $checksum_extra = ($page.Content -Split '\n' -like "*.Installer.exe" | Select-Object -First 1 | ConvertFrom-String -PropertyNames sha1sum, filename).sha1sum

    $url = "${base}/npp.${version}.bin.7z"
    $url_extra = "${base}/npp.${version}.Installer.exe"

    return @{
        Version           = $version
        URL32             = $url
        ChecksumType32    = 'SHA1'
        Checksum32        = $checksum32
        URL_Extra         = $url_extra
        ChecksumTypeExtra = 'SHA1'
        ChecksumExtra     = $checksum_extra
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
