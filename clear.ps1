$ErrorActionPreference = "Stop"

choco uninstall just --yes --remove-dependencies
choco uninstall git --yes --remove-dependencies --params="'/VERYSILENT /NORESTART'"
choco uninstall nodejs --yes --remove-dependencies
choco uninstall pnpm --yes --remove-dependencies
choco uninstall rustup --yes --remove-dependencies
choco uninstall android-sdk --yes --remove-dependencies
choco uninstall visualstudio2022buildtools --yes --remove-dependencies

Remove-Item "C:\Android" -Recurse -Force
Remove-Item "$env:TEMP\pnpm" -Recurse -Force
Remove-Item "$env:TEMP\pnpm-cache" -Recurse -Force
Remove-Item "$env:TEMP\pnpm-state" -Recurse -Force
Remove-Item "$env:TEMP\.tauri" -Recurse -Force
Remove-Item "$env:ProgramFiles\Git" -Recurse -Force
Remove-Item "$env:ProgramFiles\nodejs" -Recurse -Force
Remove-Item "$env:ProgramFiles\Java" -Recurse -Force
Remove-Item "$env:USERPROFILE\.cargo" -Recurse -Force
Remove-Item "$env:USERPROFILE\.android" -Recurse -Force
Remove-Item "$env:TEMP\chocolatey" -Recurse -Force
Remove-Item "$env:ProgramData\chocolatey" -Recurse -Force
Remove-Item "$env:ProgramData\ChocolateyHttpCache" -Recurse -Force

[Environment]::SetEnvironmentVariable(
    "Path",
    ([Environment]::GetEnvironmentVariable("Path", "Machine") -split ";" |
        Where-Object { $_ -and $_ -notlike "*chocolatey*" }) -join ";",
    "Machine"
)
