$ErrorActionPreference = "Stop"

function Remove-Path {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    $item = Get-Item -LiteralPath $Path -ErrorAction SilentlyContinue

    if ($null -eq $item) {
        return
    }

    if ($item.PSIsContainer) {
        cmd /c "rd /s /q `"$Path`"" > $null 2>&1
        return
    }

    cmd /c "del /f /q `"$Path`"" > $null 2>&1
}
