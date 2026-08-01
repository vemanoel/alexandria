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
