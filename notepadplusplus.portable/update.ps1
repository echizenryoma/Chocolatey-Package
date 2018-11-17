Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
            "(^[$]Checksum32\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
            "(^[$]ChecksumType32\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
            "(^[$]Url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
            "(^[$]Checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
            "(^[$]ChecksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

function global:au_BeforeUpdate() {
    Import-Module "$Env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"

    $UrlExtra = $Latest.URL64 -replace "bin.x64.7z", "Installer.x64.exe"
    $FilePath = Join-Path $(Get-Location) $([IO.Path]::GetFileName($UrlExtra))
    $ToolsPath = Join-Path $(Get-Location) 'tools'
    
    Remove-Item -Path $(Join-Path $ToolsPath "NppShell_*.dll") -Force -ErrorAction Ignore
    Invoke-WebRequest -Uri $UrlExtra -OutFile $FilePath
    
    $UnzipLocation = Join-Path $(Get-Location) 'tmp'
    Get-ChocolateyUnzip -FileFullPath $FilePath -Destination $UnzipLocation

    $NppShell = Get-ChildItem -Path $UnzipLocation -Filter "NppShell_*.dll" | Select-Object -First 1
    if ($NppShell) {
        Copy-Item -Path $NppShell.FullName -Destination $ToolsPath
    }
    Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore
    Remove-Item -Path $FilePath -Force -ErrorAction Ignore
}

function global:au_GetLatest {
    $url = "https://notepad-plus-plus.org/download/"
    $request = Invoke-WebRequest -Uri $url -MaximumRedirection 0 -ErrorAction Ignore
    
    $url = $request.Headers.Location
    $version = $url -Split "/" | Select-Object -Last 1
    $version = $version.Replace("v", "").Replace(".html", "").Trim()
    
    $base = "https://notepad-plus-plus.org/repository/$($version.Substring(0, $version.IndexOf("."))).x/$version"
    
    $page = Invoke-WebRequest -UseBasicParsing -Uri "${base}/npp.${version}.sha1.md5.digest.txt"
    $checksum32 = ($page.Content -Split "`n" -match "\.bin\.7z" | Select-Object -First 1 | ConvertFrom-String -PropertyNames sha1sum, filename).sha1sum
    $checksum64 = ($page.Content -Split "`n" -match "\.bin\.x64\.7z" | Select-Object -First 1 | ConvertFrom-String -PropertyNames sha1sum, filename).sha1sum

    $url32 = "${base}/npp.${version}.bin.7z"
    $url64 = "${base}/npp.${version}.bin.x64.7z"
    $checksum_type = 'sha1'

    return @{
        Version        = $version
        URL32          = $url32
        ChecksumType32 = $checksum_type
        Checksum32     = $checksum32
        URL64          = $url64
        ChecksumType64 = $checksum_type
        Checksum64     = $checksum64
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
