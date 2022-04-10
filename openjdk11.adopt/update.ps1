Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
            "(^[$]Checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
            "(^[$]ChecksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

function global:au_GetLatest {
    $url = 'https://api.github.com/repos/AdoptOpenJDK/openjdk11-binaries/releases/latest'
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $json = $page.Content | ConvertFrom-Json

    $url64 = ($json.assets | Where-Object { $_.name -NotMatch "jre" -and $_.name -NotMatch "debug" -and $_.name -Match "x64.*windows.*zip$" })[0].browser_download_url
    $url = ($json.assets | Where-Object { $_.name -NotMatch "jre" -and $_.name -NotMatch "debug" -and $_.name -Match "64.*windows.*zip.*txt" })[0].browser_download_url
    $checksum_type64 = ($url -split "\." -match "sha\d+")[0]
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $table = [System.Text.Encoding]::UTF8.GetString($page.Content) -split "\n" | ConvertFrom-String -PropertyNames checksum, file
    $checksum64 = $table.checksum

    $version = [version](($json.name -split "_")[0] -split "[a-z]|-|\+" -match "\d+(\.\d+)+" -join ".")
	
    return @{
        Version        = $version
        URL64          = $url64
        ChecksumType64 = $checksum_type64
        Checksum64     = $checksum64
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
