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

# Install Git
New-Item -ItemType Directory -Force "$env:USERPROFILE\scoop\buckets\scripts\git"
scoop install git@2.55.0.1
scoop hold git

# Install Just
scoop install just@1.57.0
scoop hold just

# Install Go
scoop install go@1.26.5
scoop hold go

# Install flutter
scoop bucket add extras
scoop update extras
scoop install flutter@3.44.8
scoop hold flutter

# Install JDK
scoop bucket add java
scoop install temurin21-jdk@21.0.12-8.0
scoop hold temurin21-jdk

# Install Android SDK Command-line Tool
scoop install android-clt@15859902
scoop hold android-clt
Refresh-Env

# Install Android SDK components
android sdk install `
    "platform-tools" `
    "platforms;android-36" `
    "ndk;28.2.13676358" `
    "build-tools;36.0.0" `
    "cmdline-tools;22.0"
