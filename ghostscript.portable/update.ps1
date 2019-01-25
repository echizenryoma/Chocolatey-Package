Import-Module AU

function global:au_SearchReplace {
    [version]$version = $Latest.Version | Select-Object -First 1
    $docsUrl = "https://www.ghostscript.com/doc/$($version)/Readme.htm"
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
            "(?i)(^\s*\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$releaseNotesUrl`${2}"
        }
    }
}

function global:au_GetLatest {
    $sld = "https://github.com"
    $base = "${sld}/ArtifexSoftware/ghostpdl-downloads/releases"
    $page = Invoke-WebRequest -UseBasicParsing -Uri "${base}/latest"
    $version = ($page.Links | Where-Object outerHTML -match "Ghostscript/GhostPDL" | Select-Object -First 1) -split "\s|<|>|/" -match "\d+(\.\d+)+"

    $url32 = $sld + ($page.Links.href -match "w.*32.*exe" | Select-Object -First 1)
    $url64 = $sld + ($page.Links.href -match "w.*64.*exe" | Select-Object -First 1)

    $checksum_type = 'sha512'
    $url = $sld + ($page.Links.href -match $checksum_type | Select-Object -First 1)
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $sha256table = [System.Text.Encoding]::UTF8.GetString($page.Content) -split "\n" | ConvertFrom-String -PropertyNames sha256sum, file
        
    $checksum32 = $sha256table | Where-Object file -Match "w.*32.*exe" | Select-Object -First 1 -ExpandProperty sha256sum
    $checksum64 = $sha256table | Where-Object file -Match "w.*64.*exe" | Select-Object -First 1 -ExpandProperty sha256sum
  
    return @{
        Version        = $version
        URL32          = $url32
        Checksum32     = $checksum32
        ChecksumType32 = $checksum_type
        URL64          = $url64
        Checksum64     = $checksum64
        ChecksumType64 = $checksum_type
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
