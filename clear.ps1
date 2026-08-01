choco uninstall just --yes
choco uninstall git --yes
choco uninstall nodejs --yes
choco uninstall pnpm --yes
choco uninstall rust --yes
choco uninstall android-sdk --yes
choco uninstall visualstudio2022buildtools --yes

Remove-Item C:\ProgramData\chocolatey -Recurse -Force

[Environment]::SetEnvironmentVariable(
    "Path",
    ([Environment]::GetEnvironmentVariable("Path", "Machine") -split ";" |
    Where-Object { $_ -notlike "*chocolatey*" }) -join ";",
    "Machine"
)
