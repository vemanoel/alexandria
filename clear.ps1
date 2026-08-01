choco uninstall just --yes
choco uninstall git --yes
choco uninstall nodejs --yes
choco uninstall pnpm --yes
choco uninstall rust --yes
choco uninstall android-sdk --yes
choco uninstall visualstudio2022buildtools --yes

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
