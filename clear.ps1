choco uninstall just --yes --remove-dependencies
choco uninstall git --yes --remove-dependencies
choco uninstall nodejs --yes --remove-dependencies
choco uninstall pnpm --yes --remove-dependencies
choco uninstall rust --yes --remove-dependencies
choco uninstall android-sdk --yes --remove-dependencies
choco uninstall visualstudio2022buildtools --yes --remove-dependencies

# Uninstall Chocolatey
Remove-Item C:\ProgramData\chocolatey -Recurse -Force
Remove-Item C:\ProgramData\ChocolateyHttpCache -Recurse -Force

[Environment]::SetEnvironmentVariable(
    "Path",
    ([Environment]::GetEnvironmentVariable("Path", "Machine") -split ";" |
    Where-Object { $_ -notlike "*chocolatey*" }) -join ";",
    "Machine"
)

# Uninstall Android Studio
Remove-Item C:\Android -Recurse -Force
Remove-Item "$env:USERPROFILE\.android" -Recurse -Force
