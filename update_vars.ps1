# AU Packages Template: https://github.com/majkinetor/au-packages-template
# Copy this file to update_vars.ps1 and set the variables there. Do not include it in the repository.

$Env:au_Push = 'false'

$Env:gist_id = '06bd306e9a1c0a26e8d81fe185ef77d0'
$Env:github_user_repo = 'echizenryoma/Chocolatey-Package'
$Env:github_api_key = "${Env:GITHUB_API_KEY}"

$Env:report_path = Join-Path $PSScriptRoot "Update-AUPackages.md"
$Env:history_path = Join-Path $PSScriptRoot "Update-History.md"