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
move-Dir "$env:USERPROFILE\.chocolatey"
Remove-Dir "$env:TEMP\chocolatey"
Remove-Dir "$env:ProgramData\chocolatey"
Remove-Dir "$env:ProgramData\ChocolateyHttpCache"

& "C:\Program Files (x86)\Microsoft Visual Studio\Installer\setup.exe" uninstall --installPath "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools" --quiet --wait --norestart
