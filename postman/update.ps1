Import-Module AU

$PackageName = "postman"

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
        }
    }
}

function global:au_GetLatest {
    $xml = [xml](Get-Content -Path $(Join-Path $PSScriptRoot "${PackageName}.nuspec"))
    $nupkg_version = $xml.package.metadata.version
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://dl.pstmn.io/update/status?channel=stable&currentVersion=${nupkg_version}&arch=64&platform=win64" -ErrorAction Ignore
    if ($page.StatusCode -eq 200) {
        $obj = ConvertFrom-Json $page.Content
        $version = $obj.version
    }
    else {
        $version = $xml.package.metadata.version
    }    

    return @{
        Version = $version
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
