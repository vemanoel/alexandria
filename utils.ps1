function Remove-Dir {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    if (Test-Path $Path) {
        Remove-Item $Path -Recurse -Force
    }
}

