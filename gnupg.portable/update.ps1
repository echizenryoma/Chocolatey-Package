Import-Module AU

function global:au_SearchReplace {
    @{
        ".\tools\ChocolateyInstall.ps1" = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $base = 'https://www.gnupg.org'
    $page = Invoke-WebRequest -UseBasicParsing -Uri "${base}/download/index.en.html"
    $file = $page.Links.href -match "gnupg-w32-\d+(\.\d+)+_\d+\.exe$" | Select-Object -Last 1
    $version = [IO.Path]::GetFileNameWithoutExtension($file) -replace "_", "." -split "-" -match "\d+(\.\d+)+" | Select-Object -First 1
    $url = $base + $file

    @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
