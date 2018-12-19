Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]Url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
            "(^[$]Checksum32\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]ChecksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
            "(^[$]Checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
            "(^[$]ChecksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

function global:au_AfterUpdate ($Package) {
    $global:Options.Push = $true
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.voidtools.com/Changes.txt'
    $version = ($page.Content -split "\n" -match 'Version\s+\d(\.\d+)+' | Select-Object -First 1) -split "\s" -match "\d(\.\d+)+" | Select-Object -First 1
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://www.voidtools.com/Everything-${version}.sha256"
    $sha256table = [System.Text.Encoding]::UTF8.GetString($page.Content) -split "\n" | ConvertFrom-String -PropertyNames sha256sum, file
    
    $checksum_type = 'sha256'
    $url32 = "https://www.voidtools.com/Everything-${version}.x86.zip"
    $url64 = "https://www.voidtools.com/Everything-${version}.x64.zip"    
    $checksum32 = $sha256table | Where-Object file -Match "x86.zip" | Select-Object -First 1 -ExpandProperty sha256sum
    $checksum64 = $sha256table | Where-Object file -Match "x64.zip" | Select-Object -First 1 -ExpandProperty sha256sum
	
    return @{
        Version        = $version
        URL32          = $url32
        URL64          = $url64
        Checksum32     = $checksum32
        ChecksumType32 = $checksum_type
        Checksum64     = $checksum64
        ChecksumType64 = $checksum_type
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
