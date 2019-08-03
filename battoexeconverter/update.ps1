Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(^[$]Checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]ChecksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_AfterUpdate ($Package) {
    $global:Options.Push = $true
}

function global:au_GetLatest {
    $base = 'https://zn.amorgan.xyz/17SWVnHoujG92yYGSZvCzPgZEpGVfRF8wi'
    $url = "${base}/b2e/en.js"
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $url32 = $base + ($page.Links.href -match "Bat-To-Exe-Converter" | Select-Object -First 1).Trim("\.")
    $md5sum = ($page.Content -split " |<|>" -match "^[a-fA-F0-9]{32,}$" | Select-Object -First 1).Trim()
    $version = ($page.Content -split " |<|>" -match "^\d+(\.\d+){1,}$" | Select-Object -First 1).Trim()
	
    return @{
        Version        = $version
        URL32          = $url32
        ChecksumType32 = 'md5'
        Checksum32     = $md5sum
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
