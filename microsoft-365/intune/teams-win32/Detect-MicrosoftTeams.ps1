$teamsPackage = Get-AppxPackage -Name "MSTeams" -AllUsers -ErrorAction SilentlyContinue

if ($teamsPackage -and $teamsPackage.Status -eq "Ok") {
    Write-Output "Microsoft Teams detected: $($teamsPackage.Version)"
    exit 0
}

exit 1
