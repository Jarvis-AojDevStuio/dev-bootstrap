[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

$requiredPaths = @(
  'README.md',
  'LICENSE',
  'bootstrap.ps1',
  'wsl/setup.sh',
  'scripts/check-structure.ps1',
  '.github/workflows/repo-health.yml'
)

$missing = @()
foreach ($p in $requiredPaths) {
  if (-not (Test-Path $p)) { $missing += $p }
}

if ($missing.Count -gt 0) {
  Write-Error ("Missing required paths:`n - " + ($missing -join "`n - "))
}

Write-Host "OK: repo structure looks correct." -ForegroundColor Green
