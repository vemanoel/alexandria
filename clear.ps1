choco pin remove -n=just
choco uninstall just --yes --remove-dependencies

choco pin remove -n=git
choco uninstall git --yes --remove-dependencies --remove-immersive --params="'/VERYSILENT /NORESTART'"

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
Remove-Item "C:\Program Files\Java" -Recurse -Force
Remove-Item "C:\ProgramData\chocolatey" -Recurse -Force
Remove-Item "C:\ProgramData\ChocolateyHttpCache" -Recurse -Force

[Environment]::SetEnvironmentVariable(
    "Path",
    ([Environment]::GetEnvironmentVariable("Path", "Machine") -split ";" |
    Where-Object { $_ -notlike "*chocolatey*" }) -join ";",
    "Machine"
)

# Uninstall Android Studio
Remove-Item C:\Android -Recurse -Force
Remove-Item "$env:USERPROFILE\.android" -Recurse -Force
