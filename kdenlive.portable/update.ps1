Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://kdenlive.org/en/download/"
    $url64 = $page.Links.href -match "standalone.exe$"
    $version_regex = '^\d+(\.\d+)+$'
    $version = $url64 -split "\-|_" -match "${version_regex}"
    
    return @{
        Version = $version
        URL64   = $url64
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
