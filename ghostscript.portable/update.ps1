Import-Module AU

function global:au_SearchReplace {
    [version]$version = $Latest.Version | Select-Object -First 1
    $docsUrl = "http://www.ghostscript.com/doc/$($version)/Readme.htm"
    $releaseNotesUrl = "https://ghostscript.com/doc/$($version)/History$($version.Major).htm"
    
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]Checksum32\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]ChecksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
            "(^[$]Url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
            "(^[$]Checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
            "(^[$]ChecksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
        "ghostscript.portable.nuspec" = @{
            "(?i)(^\s*\<docsUrl\>).*(\<\/docsUrl\>)"           = "`${1}$docsUrl`${2}"
            "(?i)(^\s*\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$releFaseNotesUrl`${2}"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/latest"
    $version = ($page.Links | Where-Object outerHTML -match "Ghostscript/GhostPDL" | Select-Object -First 1) -split "\s|<|>|/" -match "\d+(\.\d+)+"
    
    $url = "https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs$($version.Replace(".", ''))/gs$($version.Replace(".", ''))w32.exe"
    $url64 = "https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs$($version.Replace(".", ''))/gs$($version.Replace(".", ''))w64.exe"

    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs$($version.Replace(".", ''))/SHA256SUMS"
    $objs = [System.Text.Encoding]::UTF8.GetString($page.Content) -split '\n' | ConvertFrom-String -PropertyNames "SHA256SUM", "File"
  
    return @{
        Version        = $version
        URL32          = $url
        Checksum32     = ($objs | Where-Object File -Match "gs$($version.Replace(".", ''))w32.exe").SHA256SUM
        ChecksumType32 = "SHA256"
        URL64          = $url64
        Checksum64     = ($objs | Where-Object File -Match "gs$($version.Replace(".", ''))w64.exe").SHA256SUM
        ChecksumType64 = "SHA256"
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
