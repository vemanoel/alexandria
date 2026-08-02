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

# Install Scoop
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
Refresh-Env

# Install 7zip
scoop install 7zip

# Install Just
scoop install just@1.57.0
scoop hold just

# Install Git
scoop install git@2.55.0.3
scoop hold git

# Install Node
scoop install nodejs@24.18.1
scoop hold nodejs

# Install PNPM
scoop install pnpm@11.18.0
scoop hold pnpm

# Install Rust
scoop install rustup@1.29.0
scoop hold rustup

# Install JDK
scoop bucket add java
scoop update java
scoop install temurin21-jdk@21.0.12-8.0
scoop hold temurin21-jdk

# Install Android SDK Command-line Tool
scoop install android-clt@15859902
scoop hold android-clt
Refresh-Env

# Install Android SDK components
sdkmanager `
    "platform-tools" `
    "platforms;android-36" `
    "ndk;27.3.13750724" `
    "build-tools;36.0.0" `
    "cmdline-tools;22.0"

# Install Microsoft C++ Build Tools
winget install `
    --id Microsoft.VisualStudio.2022.BuildTools `
    --version 17.14.37 `
    --override "--add Microsoft.VisualStudio.Workload.VCTools --includeRecommended --quiet --wait --norestart"
