# AU Packages Template: https://github.com/majkinetor/au-packages-template

param([string[]] $Name, [string] $ForcedPackages, [string] $Root = $PSScriptRoot)

if (Test-Path $PSScriptRoot/update_vars.ps1) {
    . $PSScriptRoot/update_vars.ps1
}

$Options = [ordered]@{
    Timeout       = 60
    UpdateTimeout = 600
    Threads       = 10
    Push          = $Env:au_Push -eq 'true'
	
    Report        = @{
        Type   = 'markdown'
        Path   = "$PSScriptRoot\Update-AUPackages.md"
        Params = @{
            Github_UserRepo = $Env:github_user_repo
            UserMessage     = "[History](#update-history)"
            IconSize        = 32
        }
    }

    History       = @{
        Lines           = 30
        Github_UserRepo = $Env:github_user_repo
        Path            = "$PSScriptRoot\Update-History.md"
    }
	
    Gist          = @{
        Id     = $Env:gist_id
        ApiKey = $Env:github_api_key
        Path   = "$PSScriptRoot\Update-AUPackages.md", "$PSScriptRoot\Update-History.md"
    }
	
    Git           = @{
        Password = $Env:github_api_key
        Force    = $true
    }

    BeforeEach    = {
        param($PackageName, $Options )
        $p = $Options.ForcedPackages | Where-Object { $_ -match "^${PackageName}(?:\:(.+))*$" }
        if (!$p) {
            return
        }

        $global:au_Force = $true
        $global:au_Version = ($p -split ':')[1]
    }
}

if ($ForcedPackages) { 
    Write-Host "FORCED PACKAGES: $ForcedPackages" 
}
$global:info = Update-AUPackages -Name $Name -Options $Options
