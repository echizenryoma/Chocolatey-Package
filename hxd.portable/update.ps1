Import-Module au
function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]Checksum32\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]ChecksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    $url = 'https://mh-nexus.de/updates/HxDCurrentVersion.json'
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $json_obj = $page.Content | ConvertFrom-Json

    $version = $json_obj."Version"
    $url32 = $json_obj."Download-URI"
    $checksum_type = "SHA1"
    $checksum32 = $json_obj."Unique-File-IDs"."SHA-1"

    return @{
        URL32          = $url32
        ChecksumType32 = $checksum_type
        Checksum32     = $checksum32
        Version        = $version
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
