## Prerequisites

### Linux (OpenSUSE Tumbleweed)

```bash
bash -c '
    sudo zypper install --no-confirm --no-recommends --oldpackage 'git=2.55.0-2.3'

    sudo wget https://mise.jdx.dev/rpm/mise.repo -O /etc/zypp/repos.d/mise.repo
    sudo zypper --gpg-auto-import-keys refresh
    sudo zypper install --no-confirm --no-recommends --oldpackage 'mise=2026.8.2-1'

    PROJECT_DIR=$HOME/Documents/projects/open-source/TurboShare

    if [ -d $PROJECT_DIR ]; then
        cd $PROJECT_DIR
    else
        mkdir -p $PROJECT_DIR
        cd $PROJECT_DIR
        git clone https://github.com/vemanoel/TurboShare.git .
    fi

    mise trust
    mise install

    mise exec -- android sdk install `
        "platform-tools" `
        "platforms;android-36" `
        "build-tools;36.0.0" `
        "ndk;27.3.13750724"

    mise exec -- go mod tidy
'
```

### Windows

```powershell
@'
$ErrorActionPreference = "Stop"

winget install `
    --id Git.Git `
    --exact `
    --version 2.55.0.3 `
    --source winget `
    --force `
    --silent `
    --accept-package-agreements `
    --accept-source-agreements

winget install `\
    --id jdx.mise `
    --exact `
    --version 2026.7.15 `
    --source winget `
    --force `
    --silent `
    --accept-package-agreements `
    --accept-source-agreements

$env:Path = @(
    [Environment]::GetEnvironmentVariable("Path", "Machine")
    [Environment]::GetEnvironmentVariable("Path", "User")
) -join ";"

$project_dir = "$HOME\Documents\projects\open-source\TurboShare"

if (Test-Path -Path $project_dir) {
    Set-Location $project_dir
} else {
    New-Item -ItemType Directory -Path $project_dir -Force | Out-Null
    Set-Location $project_dir
    git clone https://github.com/vemanoel/TurboShare.git .
}

mise trust
mise install

mise exec -- android sdk install `
    "platform-tools" `
    "platforms;android-36" `
    "build-tools;36.0.0" `
    "ndk;27.3.13750724"

mise exec -- go mod tidy
'@ | Invoke-Expression
```
