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

function Choco-Uninstall {
    param(
        [Parameter(Mandatory)]
        [string]$Package,

        [string]$Params
    )

    choco pin remove -n=$Package

    $args = @(
        "uninstall"
        $Package
        "--yes"
        "--remove-dependencies"
    )

    if ($Params) {
        $args += "--params=$Params"
    }

    choco @args
}

Choco-Uninstall just
Choco-Uninstall git '/VERYSILENT /NORESTART'
Choco-Uninstall nodejs
Choco-Uninstall pnpm
Choco-Uninstall  rust
Choco-Uninstall android-sdk
Choco-Uninstall visualstudio2022buildtools

Remove-Dir "C:\Android"
Remove-Dir "$env:ProgramFiles\Java"
Remove-Dir "$env:USERPROFILE\.android"
Remove-Dir "$env:ProgramData\chocolatey"
Remove-Dir "$env:ProgramData\ChocolateyHttpCache"

[Environment]::SetEnvironmentVariable(
    "Path",
    ([Environment]::GetEnvironmentVariable("Path", "Machine") -split ";" |
    Where-Object { $_ -notlike "*chocolatey*" }) -join ";",
    "Machine"
)
