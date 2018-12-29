Import-Module AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $releases = 'https://www.libreoffice.org/download/libreoffice-still'
    $page = Invoke-WebRequest -UseBasicParsing -Uri $releases
    $url = $page.Links.href -match '\.msi$' | Select-Object -First 1
    $version = $url -split '/' | Where-Object { [version]::TryParse($_, [ref]($__)) }
    $url32 = "https://mirrors.ustc.edu.cn/tdf/libreoffice/stable/${version}/win/x86/LibreOffice_${version}_Win_x86.msi"
    $url64 = "https://mirrors.ustc.edu.cn/tdf/libreoffice/stable/${version}/win/x86_64/LibreOffice_${version}_Win_x64.msi"

    @{
        Version = $version
        URL32   = $url32
        URL64   = $url64
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
