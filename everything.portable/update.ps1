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

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.voidtools.com/Changes.txt'
    $version = $page.Content -Split "`n" | Select-String ': Version .+' | Select-Object -First 1
    $version = $version -Split ' ' | Select-Object -Last 1
    $choco_version = $version.Replace('b', '') -Replace '\.([^.]+)$', '$1'
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://www.voidtools.com/Everything-${version}.md5"
    $md5 = $page.Content -Split "\n" | ConvertFrom-String -PropertyNames md5sum, file
	
    return @{
        Version        = $choco_version;
        URL32          = "https://www.voidtools.com/Everything-${version}.x86.zip";
        URL64          = "https://www.voidtools.com/Everything-${version}.x64.zip";
        Checksum32     = $md5 | Where-Object file -Like "*x86.zip" | Select-Object -First 1 -ExpandProperty md5sum;
        ChecksumType32 = 'md5';
        Checksum64     = $md5 | Where-Object file -Like "*x64.zip" | Select-Object -First 1 -ExpandProperty md5sum;
        ChecksumType64 = 'md5';
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
