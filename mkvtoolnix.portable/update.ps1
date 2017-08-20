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
    $base = 'https://mkvtoolnix.download/windows/releases'
    $page = Invoke-WebRequest -UseBasicParsing -Uri "$base/.dirindex.php?sort=date&order=desc"
    $version = $page.Links | Where-Object title -Match '\d+(\.\d+){0,2}$' | Select-Object -Property title | Select-Object -First 1 -ExpandProperty title
    $page = Invoke-WebRequest -UseBasicParsing -Uri "$base/$version/sha1sums.txt"
    $sha1sum = $page.Content -Split '\n' | ConvertFrom-String -PropertyNames sha1sum, file
    
	return @{
        Version        = $version.Trim();
        URL32          = "${base}/${version}/mkvtoolnix-32bit-$version.7z";
        URL64          = "${base}/${version}/mkvtoolnix-64bit-$version.7z";
        ChecksumType32 = 'sha1';
        Checksum32     = $sha1sum | Where-Object file -Like "*32*7z" | Select-Object -First 1 -ExpandProperty sha1sum;
        ChecksumType64 = 'sha1';
        Checksum64     = $sha1sum | Where-Object file -Like "*64*7z" | Select-Object -First 1 -ExpandProperty sha1sum;
    }
}

Update-Package -NoCheckUrl -ChecksumFor none
