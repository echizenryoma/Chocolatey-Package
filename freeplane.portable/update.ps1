import-module AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $base = "https://sourceforge.net/projects/freeplane/files/freeplane%20stable/"
    $page = Invoke-WebRequest -UseBasicParsing -Uri $base
    $url32 = ($page.Links -match "freeplane_bin")[0].href -replace "/download", ""
    $version = [IO.Path]::GetFileNameWithoutExtension($url32) -split "-" -match "\d+(\.\d+)+" | Select-Object -First 1

    return @{
        Version = $version
        URL32   = $url32
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
