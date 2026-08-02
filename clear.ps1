$ErrorActionPreference = "Stop"

function Remove-Dir {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    if (Test-Path $Path) {
        Remove-Item $Path -Recurse -Force
    }
}

choco uninstall just --yes --remove-dependencies
choco uninstall git --yes --remove-dependencies --params="'/VERYSILENT /NORESTART'"
choco uninstall nodejs --yes --remove-dependencies
choco uninstall pnpm --yes --remove-dependencies
choco uninstall rustup --yes --remove-dependencies
choco uninstall android-sdk --yes --remove-dependencies
choco uninstall visualstudio2022buildtools --yes --remove-dependencies

Remove-Dir "C:\Android"
Remove-Dir "$env:TEMP\pnpm"
Remove-Dir "$env:TEMP\pnpm-cache"
Remove-Dir "$env:TEMP\pnpm-state"
Remove-Dir "$env:TEMP\.tauri"
Remove-Dir "$env:ProgramFiles\Git"
Remove-Dir "$env:ProgramFiles\nodejs"
Remove-Dir "$env:ProgramFiles\Java"
Remove-Dir "$env:USERPROFILE\.cargo"
Remove-Dir "$env:USERPROFILE\.android"
Remove-Dir "$env:TEMP\chocolatey"
Remove-Dir "$env:ProgramData\chocolatey"
Remove-Dir "$env:ProgramData\ChocolateyHttpCache"

[Environment]::SetEnvironmentVariable(
    "Path",
    ([Environment]::GetEnvironmentVariable("Path", "Machine") -split ";" |
        Where-Object { $_ -and $_ -notlike "*chocolatey*" }) -join ";",
    "Machine"
)
