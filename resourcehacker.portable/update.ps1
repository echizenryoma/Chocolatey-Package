Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]ChecksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "http://www.angusj.com/resourcehacker"
    $version = (($page.Content -split "\n|<|>" -match "^Version\s+\d+(\.\d+)+$")[0] -split "\s" -match "\d+(\.\d+)+")[0]

    return @{
        Version = $version
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor 32
