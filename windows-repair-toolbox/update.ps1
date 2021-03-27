Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]Checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]ChecksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://windows-repair-toolbox.com/"
    $version = ($page.Content -split "<|>|\(|\)|\n" -match "Program\s+version" | Select-Object -First 1).Trim() -split "\s|;" -match "\d+(\.\d+)+" | Select-Object -First 1
    $sha256sum = ($page.Content -split "<|>|\n" -match "SHA256\s+\(zip\)" | Select-Object -First 1).Trim() -split "\s" -match "^([0-9a-fA-F])+" | Select-Object -First 1

    return @{
        Version        = $version
        URL32          = 'https://windows-repair-toolbox.com/files/Windows_Repair_Toolbox.zip'
        ChecksumType32 = 'SHA256'
        Checksum32     = $sha256sum
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
