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

function global:au_AfterUpdate ($Package) {
    $global:Options.Push = $true
}

function global:au_GetLatest {
    $domain = "https://github.com"
    $base = "${domain}/SubtitleEdit/subtitleedit"

    $url = "${base}/releases/latest"
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $version = ($page.Links.href -match "releases/tag/(v?)\d+(\.\d+)+$" | Select-Object -Unique -First 1) -split "/|v" -match "\d+(\.\d+)+" | Select-Object -First 1

    $url = $page.Links.href -match "SE\d+\.zip$" | Select-Object -First 1
    $checksum_type = 'sha256'
    $checksum = $page.Content -split "<|>|\n" -match "^[0-9a-f]{64}$" | Select-Object -First 1 -Skip 1
	
    return @{
        Version        = $version
        URL32          = $url
        Checksum32     = $checksum
        ChecksumType32 = $checksum_type
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
