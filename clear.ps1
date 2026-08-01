$ErrorActionPreference = "Stop"

function Choco-Uninstall {
    param(
        [Parameter(Mandatory)]
        [string]$Package,

        [string]$Params
    )

    choco pin remove -n="$Package"

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

Choco-Uninstall just
Choco-Uninstall git '/VERYSILENT /NORESTART'
Choco-Uninstall nodejs
Choco-Uninstall pnpm
Choco-Uninstall rustup
Choco-Uninstall android-sdk
Choco-Uninstall visualstudio2022buildtools

Remove-Dir "C:\Android"
Remove-Dir "$env:ProgramFiles\Java"
Remove-Dir "$env:USERPROFILE\.android"
Remove-Dir "$env:ProgramData\chocolatey"
Remove-Dir "$env:ProgramData\ChocolateyHttpCache"

Remove-PathEntry "chocolatey"
