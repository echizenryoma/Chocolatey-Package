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
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://ipmsg.org/tools/fastcopy.html.en"
    $version = ($page.Content -split "\n|<|>" -match "FastCopy\s+v\d+(\.\d+)+\s+download").Trim() -split "\s|v" -match "^\d+(\.\d+)+$"
		
    return @{
        Version = $version;
        URL32   = "https://ipmsg.org/archive/FastCopy$($version.Replace(".", '')).zip";
        URL64   = "https://ipmsg.org/archive/FastCopy$($version.Replace(".", ''))_x64.zip";
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
