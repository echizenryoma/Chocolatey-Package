Import-Module AU

function global:au_SearchReplace {
    @{
        ".\tools\ChocolateyInstall.ps1" = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri 'http://ctags.sourceforge.net/'
    $version = ($page.Content -split '\n|<|>|\[|\]' -match 'Version\s+\d+(\.\d+)+' | Select-Object -First 1) -split '\s' -match '\d+(\.\d+)+'
    $url = $page.Links.href -match "ctags\d+\.zip"
    
    return @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
