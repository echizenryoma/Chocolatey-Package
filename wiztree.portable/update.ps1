Import-Module AU

function global:au_SearchReplace {
   @{
      'tools\ChocolateyInstall.ps1' = @{
         "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
      }
   }
}

function global:au_GetLatest {
   $base_url = 'https://www.diskanalyzer.com'
   $page = Invoke-WebRequest -UseBasicParsing -Uri "${base_url}/download"

   $stub = $page.Links.href -match 'wiztree.*\.zip'

   $url = "${base_url}/$stub"
   $version = ($stub -replace '.*?([0-9._]+).*?\.zip.*', '$1' -replace '_', '.').trim('.')

   return @{ 
      Version = $Version
      URL32   = $url
   }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none -NoCheckUrl
