Import-Module AU

function global:au_SearchReplace {
  @{
    'tools\ChocolateyInstall.ps1' = @{
      "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
    }
  }
}

function global:au_GetLatest {
  $base = "https://github.com"
  $page = Invoke-WebRequest -UseBasicParsing -Uri "$base/wixtoolset/wix3/releases/latest"
  $version = ($page.Links.outerHTML -match "WiX\s+Toolset" -split "\s|v|<|>" -match "^\d+(\.\d+)+$")[0]
  $url32 = 'https://github.com' + ($page.Links.href -match "-binaries.zip$")[0]

  return @{
    Version = $version
    URL32   = $url32
  }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
