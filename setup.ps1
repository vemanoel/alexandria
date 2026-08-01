$ErrorActionPreference = "Stop"

function Refresh-Env {
    [Environment]::GetEnvironmentVariables("Machine").GetEnumerator() | ForEach-Object {
        Set-Item -Path "Env:$($_.Key)" -Value $_.Value
    }

    [Environment]::GetEnvironmentVariables("User").GetEnumerator() | ForEach-Object {
        Set-Item -Path "Env:$($_.Key)" -Value $_.Value
    }

    $env:Path = @(
        [Environment]::GetEnvironmentVariable("Path", "Machine")
        [Environment]::GetEnvironmentVariable("Path", "User")
    ) -join ";"
}

# Install Chocolatey
Remove-Item C:\ProgramData\chocolatey -Recurse -Force
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
Refresh-Env

# Install Zed
choco install zed-editor --yes --limit-output

# Install Just
choco install just --version=1.57.0 --yes --limit-output
choco pin add -n=just

# Install Git
choco install git --version=2.55.0 --yes --limit-output
choco pin add -n=git

# Install Node
choco install nodejs --version=26.0.0 --yes --limit-output
choco pin add -n=nodejs

# Install PNPM
choco install pnpm --version=11.18.0 --yes --limit-output
choco pin add -n=pnpm

# Install Rust
choco install rust --version=1.97.0 --yes --limit-output
choco pin add -n=rust
     
# Install Android SDK Command-line Tool
choco install android-sdk --yes --limit-output
Refresh-Env
sdkmanager "platform-tools" "platforms;android-36" "ndk;27.3.13750724" "build-tools;36.0.0"

# Install Microsoft C++ Build Tools
choco install visualstudio2022buildtools --package-parameters "--add Microsoft.VisualStudio.Workload.VCTools --includeRecommended --passive" --yes
