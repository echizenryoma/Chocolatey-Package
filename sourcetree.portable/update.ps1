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
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://www.sourcetreeapp.com/"
    $url = $page.Links -match "SourceTreeSetup-\d+(\.\d+)+\.exe" | Select-Object -First 1 -ExpandProperty href
    $version = $url -split "\\|/|-|\.exe" -match '\d+(\.\d+)+'

    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://www.sourcetreeapp.com/update/windows/ga/RELEASES"
    $page = [System.Text.Encoding]::ASCII.GetString($page.Content)

    $release = ($page -split "\n" -match "$version" -notmatch "delta|#"  | ConvertFrom-String -PropertyNames sha1sum, filename, filesize) | Select-Object -Last 1

    $url = "https://www.sourcetreeapp.com/update/windows/ga/" + $release.filename
	
    return @{
        Version        = $version
        URL32          = $url
        Checksum32     = ($release.sha1sum).ToLower()
        ChecksumType32 = 'sha1'
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
