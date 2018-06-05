Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $base = "https://github.com"

    $page = Invoke-WebRequest -UseBasicParsing -Uri "${base}/oneclick/rubyinstaller2/releases/latest"
    $url64 = $base + ($page.Links.href -match "rubyinstaller-.*-x64\.7z$")
    $url32 = $base + ($page.Links.href -match "rubyinstaller-.*-x86\.7z$")

    $version = ([IO.Path]::GetFileNameWithoutExtension($url64) -split "-" -match "^\d+(\.\d+)*$") -join "."

    return @{
        Version = $version
        URL32   = $url32
        URL64   = $url64
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
