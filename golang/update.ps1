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
    $page = Invoke-WebRequest -UseBasicParsing -Uri 'https://golang.org/dl'
    $version = (($page.Links.href -match 'go\d+(\.\d+)+\.windows-amd64\.zip')[0] -split 'go|windows' -match '\d+(\.\d+)+').Trim(".")
    $url32 = "https://dl.goolge.com/go/go${version}.windows-386.zip"
    $url64 = "https://dl.goolge.com/go/go${version}.windows-amd64.zip"
    
    return @{
        Version = $version
        URL32   = $url32
        URL64   = $url64
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
