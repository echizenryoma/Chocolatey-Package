Import-Module AU

function global:au_SearchReplace {
    @{
        ".\tools\ChocolateyInstall.ps1" = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri 'https://golang.org'
    $version = ($page.Content -split '\n|<|>' -match 'Build\s+version\s+go\d+(\.\d)+').Trim(".") -split '\s|go' -match '\d+(\.\d)+'
    $url32 = "https://storage.googleapis.com/golang/go${version}.windows-386.zip"
    $url64 = "https://storage.googleapis.com/golang/go${version}.windows-amd64.zip"
    
    return @{
        Version = $version
        URL32   = $url32
        URL64   = $url64
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
