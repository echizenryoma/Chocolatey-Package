Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $base = "https://sourceforge.net/projects/smplayer/files/SMPlayer"
    $url = $base
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $version = ($page.Links.title -match "\d+(\.\d+)+$") -split "\s" -match "\d+(\.\d+)+$" | Select-Object -Unique -First 1
    $url = "${base}/${version}"

    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $url64 = ($page.Links.href -match "smplayer.*x64.exe/download") | Select-Object -First 1
	
    return @{
        Version = $version
        URL64   = $url64
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
