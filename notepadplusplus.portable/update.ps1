Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]Checksum32\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]ChecksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
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
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $version = ($page.Links -match "Current\s+Version")[0].href -Split "v|/" -match "\d+(\.\d+)+" | Select-Object -Last 1
    
    $base = "https://notepad-plus-plus.org/repository/$($version.Substring(0, $version.IndexOf("."))).x/$version"
    
    $checksum_type = 'sha256'
    $page = Invoke-WebRequest -UseBasicParsing -Uri "${base}/npp.${version}.checksums.$checksum_type"
    $table = $page.Content -Split "`n" | ConvertFrom-String -PropertyNames checksum, filename
    $checksum32 = ($table | Where-Object filename -match "\.bin\.7z").checksum
    $checksum64 = ($table | Where-Object filename -match "\.bin\.x64\.7z").checksum
     
    $url32 = "${base}/npp.${version}.bin.7z"
    $url64 = "${base}/npp.${version}.bin.x64.7z"    

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

Update-Package -NoCheckChocoVersion -ChecksumFor none
