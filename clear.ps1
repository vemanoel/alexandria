. "$PSScriptRoot\utils.ps1"

choco pin remove -n=just
choco uninstall just --yes --remove-dependencies

choco pin remove -n=git
choco uninstall git --yes --remove-dependencies --params="'/VERYSILENT /NORESTART'"

choco pin remove -n=nodejs
choco uninstall nodejs --yes --remove-dependencies

choco pin remove -n=pnpm
choco uninstall pnpm --yes --remove-dependencies

choco pin remove -n=rust
choco uninstall rust --yes --remove-dependencies

choco pin remove -n=android-sdk
choco uninstall android-sdk --yes --remove-dependencies

choco pin remove -n=visualstudio2022buildtools
choco uninstall visualstudio2022buildtools --yes --remove-dependencies

# Uninstall Chocolatey
Remove-Dir "$env:ProgramData\chocolatey"
Remove-Dir "$env:ProgramData\ChocolateyHttpCache"

[Environment]::SetEnvironmentVariable(
    "Path",
    ([Environment]::GetEnvironmentVariable("Path", "Machine") -split ";" |
    Where-Object { $_ -notlike "*chocolatey*" }) -join ";",
    "Machine"
)

# Uninstall Android Studio
Remove-Dir "C:\Program Files\Java"
Remove-Dir "C:\Android"
Remove-Dir "$env:USERPROFILE\.android"
