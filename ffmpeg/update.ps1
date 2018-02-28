Import-Module AU

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $base32 = "https://ffmpeg.zeranoe.com/builds/win32/shared/"

    $page = Invoke-WebRequest -UseBasicParsing -Uri $base32
    $version = ($page.Links.href -match '\d+(\.\d+)+\-win32\-.*\.(zip|7z)$') -split '-' -match '\d+(\.\d+)+' | Select-Object -Last 1
    $url32 = $base32 + ($page.Links.href -match "\-${version}\-")

    $base64 = $base32 -replace 'win32', 'win64'
    $page = Invoke-WebRequest -UseBasicParsing -Uri $base64
    $url64 = $base64 + ($page.Links.href -match "\-${version}\-")

    return @{ 
        Version = $version
        URL32   = $url32
        URL64   = $url64
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
