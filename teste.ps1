$ErrorActionPreference = "Stop"

winget install `
    --id Microsoft.VisualStudio.2022.BuildTools `
    --exact `
    --version 17.14.37 `
    --source winget `
    --silent `
    --accept-package-agreements `
    --accept-source-agreements `
    --override "--norestart --wait --quiet --add Microsoft.VisualStudio.Workload.VCTools"

winget install `
    --id jdx.mise `
    --exact `
    --version 2026.7.15 `
    --source winget `
    --silent `
    --accept-package-agreements `
    --accept-source-agreements

$env:Path = @(
    [Environment]::GetEnvironmentVariable("Path", "Machine")
    [Environment]::GetEnvironmentVariable("Path", "User")
) -join ";"

mise trust
mise install

(& mise activate pwsh) | Out-String | Invoke-Expression

android sdk install "platform-tools" "platforms;android-36" "build-tools;36.0.0" "ndk;27.3.13750724"

Set-Location -Path .\frontend
aube install
