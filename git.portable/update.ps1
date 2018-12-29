import-module AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/git-for-windows/git/releases/latest" 
    $url32 = "https://github.com" + ($page.Links.href -match "32-bit.7z.exe" | Select-Object -First 1)
    $url64 = "https://github.com" + ($page.Links.href -match "64-bit.7z.exe" | Select-Object -First 1)
    $version = [IO.Path]::GetFileNameWithoutExtension($url32) -split "-" -match "\d+(\.\d+)+" | Select-Object -First 1

    return @{
        Version = $version
        URL32   = $url32
        URL64   = $url64
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
