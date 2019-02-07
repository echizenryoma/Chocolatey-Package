Import-Module AU

function global:au_SearchReplace {
    @{
        "tools\ChocolateyInstall.ps1" = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }

        "sourcetree.portable.nuspec"  = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_GetLatest {
    $release_url = "https://www.sourcetreeapp.com/enterprise"
    $page = Invoke-WebRequest -UseBasicParsing -Uri $release_url

    $url = $page.Links.href -match "SourcetreeEnterpriseSetup_(.*).msi" | Select-Object -Unique | Select-Object -Last 1
    $version = $url -split "_|\.msi" -match "\d+(\.\d+)+" | Select-Object -First 1
    $release_notes = "https://www.sourcetreeapp.com/update/windows/ga/ReleaseNotes_${version}.html"

    return @{
        Version      = $version
        URL32        = $url
        ReleaseNotes = $release_notes
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
