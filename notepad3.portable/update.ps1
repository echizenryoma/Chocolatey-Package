Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $base = "https://github.com"
    $url = $base + "/rizonesoft/Notepad3/releases/latest"
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $version = ($page.Links | Where-Object outerHTML -Match "Notepad3 Release")[0].href -split "_" -match "\d+(\.\d+)+"
    $url32 = $base + ($page.Links.href -match "Notepad3_${version}.zip")[0]
	
    return @{
        Version = $version
        URL32   = $url32
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none