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
Remove-Dir "$env:ProgramData\chocolatey"
Remove-Dir "$env:ProgramData\ChocolateyHttpCache"
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
Refresh-Env

# Install Just
choco install just --version="1.57.0" --yes --limit-output --failonstderr
choco pin add -n=just

# Install Git
choco install git --version="2.55.0" --yes --limit-output --failonstderr
choco pin add -n=git

# Install Node
choco install nodejs --version="24.18.1" --yes --limit-output --failonstderr
choco pin add -n=nodejs

# Install PNPM
choco install pnpm --version="11.18.0" --yes --limit-output --failonstderr
choco pin add -n=pnpm

# Install Rust
choco install rust --version="1.97.0" --yes --limit-output --failonstderr
choco pin add -n=rust
     
# Install Android SDK Command-line Tool
choco install android-sdk --version="26.1.1" --yes --limit-output --failonstderr
Refresh-Env
sdkmanager "platform-tools" "platforms;android-36" "ndk;27.3.13750724" "build-tools;36.0.0" "cmdline-tools;22.0"

# Install Microsoft C++ Build Tools
choco install visualstudio2022buildtools --version=117.14.37 --package-parameters "--add Microsoft.VisualStudio.Workload.VCTools --includeRecommended --quiet --wait" --yes --limit-output --failonstderr
