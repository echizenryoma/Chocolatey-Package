# AU Packages Template: https://github.com/majkinetor/au-packages-template

param([string[]] $Name, [string] $ForcedPackages, [string] $Root = $PSScriptRoot)

if (Test-Path $PSScriptRoot/update_vars.ps1) { . $PSScriptRoot/update_vars.ps1 }

$Options = [ordered]@{
    Timeout             = 15
    UpdateTimeout       = 600
    Threads             = 10
    Push                = $Env:au_Push -eq 'true'
    
    IgnoreOn            = @(                                  # Error message parts to set the package ignore status
        'Could not create SSL/TLS secure channel'
        'Could not establish trust relationship'
        'The operation has timed out'
        'Internal Server Error'
        'Service Temporarily Unavailable'
        'Origin Time-out'
    )
    
    RepeatOn            = @(                                  # Error message parts on which to repeat package updater
        'Could not create SSL/TLS secure channel'             # https://github.com/chocolatey/chocolatey-coreteampackages/issues/718
        'Could not establish trust relationship'              # -||-
        'Unable to connect'
        'The remote name could not be resolved'
        'Choco pack failed with exit code 1'                  # https://github.com/chocolatey/chocolatey-coreteampackages/issues/721
        'The operation has timed out'
        'Internal Server Error'
        'An exception occurred during a WebClient request'
        'remote session failed with an unexpected state'
    )
    
    NoCheckChocoVersion = $true
	
    History             = @{
        Lines           = 30
        Github_UserRepo = $Env:github_user_repo
        Path            = $Env:history_path
    }
	
    Gist                = @{
        Id     = $Env:gist_id
        ApiKey = $Env:github_api_key
        Path   = @($Env:history_path)
    }
	
    Git                 = @{
        Password = $Env:github_api_key
        Force    = $true
    }

    ForcedPackages      = $ForcedPackages -split ' '

    BeforeEach          = {
        param($PackageName, $Options )

        $pattern = "^${PackageName}(?:\\(?<stream>[^:]+))?(?:\:(?<version>.+))?$"
        $p = $Options.ForcedPackages | Where-Object { $_ -match $pattern }
        if (!$p) { return }

        $global:au_Force = $true
        $global:au_IncludeStream = $Matches['stream']
        $global:au_Version = $Matches['version']
    }
}

if ($ForcedPackages) { Write-Host "FORCED PACKAGES: $ForcedPackages" }
$global:au_Root = $Root          #Path to the AU packages
$global:au_GalleryUrl = ''       #URL to package gallery, leave empty for Chocolatey Gallery
$global:info = updateall -Name $Name -Options $Options


#Uncomment to fail the build on AppVeyor on any package error
#if ($global:info.error_count.total) { throw 'Errors during update' }
