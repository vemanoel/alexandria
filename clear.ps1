. "$PSScriptRoot\utils.ps1"

choco pin remove -n=just
choco uninstall just --yes --remove-dependencies --remove-immersive

choco pin remove -n=git
choco uninstall git --yes --remove-dependencies --remove-immersive --params="'/VERYSILENT /NORESTART'"

choco pin remove -n=nodejs
choco uninstall nodejs --yes --remove-dependencies --remove-immersive

choco pin remove -n=pnpm
choco uninstall pnpm --yes --remove-dependencies --remove-immersive

choco pin remove -n=rust
choco uninstall rust --yes --remove-dependencies --remove-immersive

choco pin remove -n=android-sdk
choco uninstall android-sdk --yes --remove-dependencies --remove-immersive

choco pin remove -n=visualstudio2022buildtools
choco uninstall visualstudio2022buildtools --yes --remove-dependencies --remove-immersive

# Uninstall Chocolatey
Remove-Dir "C:\ProgramData\chocolatey"
Remove-Dir "C:\ProgramData\ChocolateyHttpCache"

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
