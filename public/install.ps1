# Bootstrap script - downloads and runs the main installer with proper UTF-8 encoding
# Usage: irm https://shsh2026.netlify.app/install.ps1 | iex

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

$scriptUrl = "https://shsh2026.netlify.app/install-course-env.ps1"

try {
    $response = Invoke-WebRequest -Uri $scriptUrl -UseBasicParsing -ErrorAction Stop

    if ($response.Content -is [byte[]]) {
        # Remove BOM if present and decode as UTF-8
        $bytes = $response.Content
        if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
            $bytes = $bytes[3..($bytes.Length - 1)]
        }
        $script = [System.Text.Encoding]::UTF8.GetString($bytes)
    } else {
        $script = $response.Content
        # Remove BOM if present in string
        if ($script.StartsWith([char]0xFEFF)) {
            $script = $script.Substring(1)
        }
    }

    Invoke-Expression $script
} catch {
    Write-Host "[ERROR] Failed to download or run installer: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please try downloading manually:" -ForegroundColor Yellow
    Write-Host "  1. Open: $scriptUrl" -ForegroundColor Cyan
    Write-Host "  2. Save as: install-course-env.ps1" -ForegroundColor Cyan
    Write-Host "  3. Right-click and 'Run with PowerShell'" -ForegroundColor Cyan
}
