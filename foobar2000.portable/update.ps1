Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
        }
    }
}

function global:au_GetLatest {
    $base = "https://www.foobar2000.org"
    $page = Invoke-WebRequest -UseBasicParsing -Uri "$base/download"

    $url = $base + ($page.Links.href -match "\.exe$" | Select-Object -Unique -First 1)
    $version = $url -split "v|_|\.exe" -match "\d+(\.\d+)+" | Select-Object -Unique -Last 1
	
    return @{
        Version = $version
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
