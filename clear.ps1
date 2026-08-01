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

function Remove-PathEntry {
    param(
        [Parameter(Mandatory)]
        [string]$Pattern,

        [ValidateSet("Machine", "User")]
        [string]$Scope = "Machine"
    )

    $path = [Environment]::GetEnvironmentVariable("Path", $Scope)

    $newPath = ($path -split ";" |
        Where-Object {
            $_ -and $_ -notlike "*$Pattern*"
        }) -join ";"

    [Environment]::SetEnvironmentVariable(
        "Path",
        $newPath,
        $Scope
    )
}

choco uninstall just --yes --remove-dependencies
choco uninstall git --yes --remove-dependencies --params="'/VERYSILENT /NORESTART'"
choco uninstall nodejs --yes --remove-dependencies
choco uninstall pnpm --yes --remove-dependencies
choco uninstall rustup --yes --remove-dependencies
choco uninstall android-sdk --yes --remove-dependencies
choco uninstall visualstudio2022buildtools --yes --remove-dependencies

Remove-Dir "C:\Android"
Remove-Dir "$env:ProgramFiles\Java"
Remove-Dir "$env:USERPROFILE\.android"
Remove-Dir "$env:ProgramData\chocolatey"
Remove-Dir "$env:ProgramData\ChocolateyHttpCache"

Remove-PathEntry "chocolatey"
