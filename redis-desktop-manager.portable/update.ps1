Import-Module AU

function global:au_SearchReplace {
    [version]$version = $Latest.Version | Select-Object -First 1
    $branch = "$($version.Major).$($version.Minor)"
    $licenseUrl = "https://raw.githubusercontent.com/uglide/RedisDesktopManager/$($branch)/LICENSE"
    
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
        "redis-desktop-manager.portable.nuspec" = @{
            "(?i)(^\s*\<licenseUrl\>).*(\<\/licenseUrl\>)" = "`${1}$licenseUrl`${2}"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/uglide/RedisDesktopManager/releases/latest"
    $url = "https://github.com" + ($page.Links.href -match "redis-desktop-manager-\d+(\.\d+)+\.exe" | Select-Object -First 1)
    $version = [IO.Path]::GetFileNameWithoutExtension($url) -split "-" -match "\d+(\.\d+)+" | Select-Object -First 1
	
    return @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
