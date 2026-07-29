$ErrorActionPreference = "Stop"

function Refresh-Path {
    $env:Path = @(
        [Environment]::GetEnvironmentVariable("Path", "Machine")
        [Environment]::GetEnvironmentVariable("Path", "User")
    ) -join ";"
}

# Install Scoop
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
Refresh-Path

# Install Git
scoop install git
Refresh-Path

# Add extras bucket for Scoop
scoop bucket add extras

# Install Go
scoop install go
Refresh-Path

# Install Wails CLI
go install github.com/wailsapp/wails/v3/cmd/wails3@latest
Refresh-Path

# Install Node.JS
scoop install nodejs-lts

# Install PNPM
scoop install pnpm

# Install Just
scoop install just
Refresh-Path

# Install WebView2 Runtime
scoop install extras/webview2
Refresh-Path

# Install Android SDK Platform-Tools
scoop install adb
Refresh-Path

# Install Android command-line tools
scoop install android-clt
Refresh-Path

# Install Android SDK components
sdkmanager "platform-tools" "platforms;android-35" "build-tools;35.0.0" "ndk;26.3.11579264" "emulator" "system-images;android-35;google_apis;arm64-v8a"

# Create Android Virtual Device (AVD)
avdmanager create avd --name wails --package "system-images;android-35;google_apis;arm64-v8a" --device pixel_7

# Install JDK
scoop bucket add java
scoop install openjdk21
Refresh-Path

# Clone the repository
git clone https://github.com/vemanoel/alexandria.git
cd alexandria
