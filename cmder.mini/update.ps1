Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/cmderdev/cmder/releases/latest"
    $url32 = 'https://github.com' + ($page.Links.href -match "cmder_mini" | Select-Object -First 1)
    $version = $url32 -split "/|v" -match "\d+(\.\d+)+" | Select-Object -First 1

    return @{
        Version = $version
        URL32   = $url32
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none