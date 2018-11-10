Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_AfterUpdate ($Package)  {
    $global:Options.Push = $true
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://api.github.com/repos/x64dbg/x64dbg/releases/latest"
    $json = $page.Content | ConvertFrom-Json
    $url = $json.assets.browser_download_url
    $version = ($url -split "\.|_" -match "\d+(-\d+)+$" -Replace "-", "" | Select-Object -First 2) -join "."
	
    return @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
