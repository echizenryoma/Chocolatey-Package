import-module AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $base = "https://sourceforge.net/projects/gmkvextractgui/files"
    $page = Invoke-WebRequest -UseBasicParsing -Uri $base
    $url32 = $base + (($page.Links -match "Download\s+Latest\s+Version" | Select-Object -First 1 -ExpandProperty title) -split ":|\s" | Select-Object -First 1)
    $version = [IO.Path]::GetFileNameWithoutExtension($url32) -split "v" -match "\d+(\.\d+)+" | Select-Object -First 1

    return @{
        Version = $version
        URL32   = $url32
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
